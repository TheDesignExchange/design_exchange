# require "rdf"
# require "rdf/raptor"
# include RDF
# Reset users

User.destroy_all

# Create default admin user
# TODO: Use AdminUser class instead? If so, make sure design methods can be owned by AdminUser class as well as User class

admin = User.create!(
  email: "admin@thedesignexchange.org",
  password: "thedesignexchange",
  password_confirmation: "thedesignexchange",
)

p "Admin #{admin.email} created!" if admin.save
p admin.errors unless admin.save

# Read in the ontology
filename = File.join(Rails.root, 'lib/tasks/data/dx.owl')
fields = Hash.new

DesignMethod.destroy_all
MethodCategory.destroy_all
Citation.destroy_all

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
all_objects.delete_if { |str| str == nil || str.match(/,|\(|\)|\\|\//) }
all_subjects.delete_if { |str| str == nil || str.match(/,|\(|\)|\\|\//) }

# The design methods are the individuals (no subclasses) - right now this over-selects
only_methods = all_subjects - all_objects
p only_methods

# The five root method categories. Only loading Bulding section for now.
building = MethodCategory.create(name: "Building")
comm = MethodCategory.create(name: "Communicating")
data_g = MethodCategory.create(name: "Data_Gathering")
data_p = MethodCategory.create(name: "Data_Processing")
ideating = MethodCategory.create(name: "Ideating")

METHOD_CATEGORIES = { building.name => building, 
                        comm.name => comm, 
                        data_g.name => data_g,
                        data_c.name => data_c,
                        ideating.name => ideating }

def load_field(method, search_property)
  to_return = ""
  search_term = SPARQL.parse("#{ROOT_PREFIX} SELECT ?field { :#{method} :#{search_property} ?field }")
  DATA.query(search_term).each do |results|
    to_return _= results.obj.to_s
  end

  if to_return.empty?
    to_return = "default"
  end

  return to_return
end


# Instantiating design methods.
only_methods.each do |method_name|

  method = instantiate_method(method_name)
  if method
    load_citation(method)
    load_parents(method)
  end
end


def instantiate_method(name)
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

  fields[:name] = name
  fields[:overview] = overview
  fields[:process] = process
  fields[:principle] = principle

  design_method = DesignMethod.new(fields)
  design_method.owner = admin

  if !design_method.save
    p "Error while creating a design method: "
    design_method.errors.full_messages.each do |message|
      p "\t#{message}"
    end
  else
    p "Added design method: #{design_method.name}"
    return design_method
  end
end

# Load in citations. Ignoring hasReference field, using Annotation Property: references.
def load_citation(design_method)
  citations = SPARQL.parse("#{ROOT_PREFIX} SELECT ?ref { :#{design_method.name} :references ?ref }")
  DATA.query(citations).each do |results|
    cit_text = results.ref.to_s
    citation = Citation.where(text: cit_text).first_or_create!
    if !design_method.citations.include?(citation)
      design_method.citations << citation
      p "    Added citation #{cit_text}"
    end
  end
end

# Loads any parents of the design methods. Recursive.
def load_parents(design_method)
  parents = SPARQL.parse("#{root_prefix} SELECT ?obj { :#{design_method.name} <#{RDF::RDFS.subClassOf}> ?obj }")
  data.query(parents).each do |results|
    parent_name = results.obj.to_s.split('#')[1]
    if parent_name
      if METHOD_CATEGORIES.include?(parent_name)
        category = METHOD_CATEGORIES[parent_name]
        if category && !design_method.method_categories.include?(category)
          design_method.method_categories << category
          p "    Added category #{cat_name}"
        end
      else
        method = DesignMethod.where(name: parent_name).first
        if method && !method.variations.include?(design_method)
          method.variations << design_method
          p "    Added variation #{design_method.name} to #{parent_name}"
        else
          parent_method = instantiate_method(method)
          if parent_method
            load_citation(parent_method)
            load_parents(parent_method)
          end
        end
      end
    end
  end
end