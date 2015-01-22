# require "rdf"
# require "rdf/raptor"
# include RDF
# Reset users

User.destroy_all

# Create default admin user

ADMIN = User.new(
  username: "admin",
  first_name: "TheDesignExchange",
  last_name: "Admin",
  email: "admin@thedesignexchange.org",
  password: "thedesignexchange",
  password_confirmation: "thedesignexchange",
)

p "Admin #{ADMIN.username} created!" if ADMIN.save
p ADMIN.errors unless ADMIN.save

#Clear old instances
p "========= RESET ==========="
DesignMethod.destroy_all
MethodCategory.destroy_all
Citation.destroy_all

# Read in the ontology
filename = File.join(Rails.root, 'lib/tasks/data/dx.owl')
DATA = RDF::Graph.load(filename)

# SPARQL prefix
ROOT_PREFIX = "PREFIX : <http://www.semanticweb.org/howard/ontologies/2014/0/DesignExchange_Methods#>"

# Searching for design methods and method categories, using the subClassOf relationship.
# This should be fixed w/something more convenient -- have some kind of predicate I can search on.
# Hm, based on how this looks, might need to add descriptions to the method categories as well.

methods = SPARQL.parse("SELECT ?subj ?obj { ?subj <#{RDF::RDFS.subClassOf}> ?obj }")
all_objects = Set.new
all_subjects = Set.new

DATA.query(methods).each do |results|
  all_objects << results.obj.to_s.split('#')[1]
  all_subjects << results.subj.to_s.split('#')[1]
end

# Deleting entries with punctuation that's troublesome for SPARQL queries
all_objects.delete_if { |str| str == nil || str.match(/,|\(|\)|\\|\/|\[|\]/) }
all_subjects.delete_if { |str| str == nil || str.match(/,|\(|\)|\\|\/\[|\]/) }

# The design methods are the individuals (no subclasses) - right now this over-selects
only_methods = all_subjects - all_objects

# The five root method categories.
p "=================== INSTANTIATING METHOD CATEGORIES ==================="

METHOD_CATEGORIES = ["Building", "Communicating", "Data_Gathering", "Data_Processing", "Ideating"]
p METHOD_CATEGORIES

METHOD_CATEGORIES.each do |cat_name|
  method_category = MethodCategory.new(name: cat_name)
  if method_category.save
    p "Added method category: #{method_category.name}"
  else
    p "Error while creating a method category: "
    method_category.errors.full_messages.each do |message|
      p "\t#{message}"
    end
  end
end

#Loads a field
def load_field(method, search_property)
  to_return = ""
  search_term = SPARQL.parse("#{ROOT_PREFIX} SELECT ?field { :#{method} :#{search_property} ?field }")
  DATA.query(search_term).each do |results|
    to_return = results.field.to_s
  end

  if to_return.empty?
    to_return = "default"
  end

  return to_return
end

# Load in citations. Ignoring hasReference field, using Annotation Property: references.
def load_citation(design_method)
  citations = SPARQL.parse("#{ROOT_PREFIX} SELECT ?ref { :#{design_method.name} :references ?ref }")
  DATA.query(citations).each do |results|
    cit_text = load_field(design_method.name, "references")
    citation = Citation.where(text: cit_text).first_or_create!
    if !design_method.citations.include?(citation)
      design_method.citations << citation
      p "    Added citation #{cit_text}"
    end
  end
end

# Loads any parents of the design methods. Will either be all categories, or all parent methods.
def load_parents(design_method)
  parents = SPARQL.parse("#{ROOT_PREFIX} SELECT ?obj { :#{design_method.name} <#{RDF::RDFS.subClassOf}> ?obj }")
  DATA.query(parents).each do |results|
    parent_name = results.obj.to_s.split('#')[1]
    if parent_name
      if METHOD_CATEGORIES.include?(parent_name)
        category = MethodCategory.where(name: parent_name).first
        if category && !design_method.method_categories.include?(category)
          design_method.method_categories << category
          p "    Added category #{category.name}"
        end
      else
        method = DesignMethod.where(name: parent_name).first
        if method && !method.variations.include?(design_method) && !method == "Method"
          method.variations << design_method
          p "    Added variation #{design_method.name} to #{parent_name}"
        else
          parent_method = instantiate_method(parent_name)
          if parent_method
            load_citation(parent_method)
            load_parents(parent_method)
            if !parent_method.variations.include?(design_method)
              parent_method.variations << design_method
              p "    Added variation #{design_method.name} to #{parent_name}"
            end
          end
        end
      end
    end
  end
end

def instantiate_method(name)
  existing_method = DesignMethod.where(name: name).first
  if name.match(/,|\(|\)|\\|\/|\[|\]/)
    return
  elsif existing_method
    return existing_method
  else
     # Filling in fields: currently dealing with 2 different labeling systems until OWL gets cleaned up
    overview = load_field(name, "Description")
    if overview == "default"
      overview = load_field(name, "hasOverview")
    end

    process = load_field(name, "process")
    if process == "default"
      process = load_field(name, "hasProcess")
    end

    principle = load_field(name, "Notes")
    if principle == "default"
      principle = load_field(name, "hasPrinciple")
    end

    fields = Hash.new

    fields[:name] = name
    fields[:overview] = overview
    fields[:process] = process
    fields[:principle] = principle

    design_method = DesignMethod.new(fields)
    design_method.owner = ADMIN
    design_method.principle = ""

    if !design_method.save
      p "Error while creating a design method #{name} "
      design_method.errors.full_messages.each do |message|
        p "\t#{message}"
      end
      return
    else
      p "Added design method: #{design_method.name}"
      return design_method
    end
  end
end

def destroy_extras(not_method)
  if not_method
    not_method.variations.each do |to_destroy|
      name = to_destroy.name
      destroy_extras(to_destroy)
      p "Destroyed #{name}."
    end
  end
end


# Instantiating design methods.
p "============= INSTANTIATING DESIGN METHODS ==============="
only_methods.each do |method_name|

  method = instantiate_method(method_name)
  if method
    load_citation(method)
    load_parents(method)
  end
end

# Destroy extra methods that aren't under the Method root. Currently lacking a consistent pattern to catch these before creation.
p "============= DESTROY NOT-METHODS =============="
destroy_extras(DesignMethod.where(name: "Person").first)
destroy_extras(DesignMethod.where(name: "Skills").first)
destroy_extras(DesignMethod.where(name: "Processes").first)
destroy_extras(DesignMethod.where(name: "Method_Characteristics").first)

