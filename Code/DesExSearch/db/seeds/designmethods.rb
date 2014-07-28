# require "rdf"
# require "rdf/raptor"
# include RDF
# Reset users

User.destroy_all

# Create default admin user

admin = User.create!(
  email: "admin@thedesignexchange.org",
  password: "thedesignexchange",
  password_confirmation: "thedesignexchange",
)

# Read in the ontology

filename = File.join(Rails.root, 'lib/tasks/data/dx_7_09.owl')
fields = Hash.new

DesignMethod.destroy_all
MethodCategory.destroy_all
Citation.destroy_all

data = RDF::Graph.load(filename)

# SPARQL prefix
ROOT_PREFIX = "PREFIX : <http://www.semanticweb.org/howard/ontologies/2014/0/DesignExchange_Methods#>"

categories = SPARQL.parse("#{ROOT_PREFIX} SELECT ?subject { ?subject :isMethodCategory ?object")
all_categories = Set.new

data.query(categories).each do |results|
  all_categories << results.subject.to_s.split('#')[1]
end

methods = SPARQL.parse("#{ROOT_PREFIX} SELECT ?subject { ?subject RDF::RDFS.subClassOf ?object")
all_methods = Set.new

data.query(methods).each do |results|
  all_methods << results.subject.to_s.split('#')[1]
end

only_methods = all_methods - all_categories
p only_methods

# Instantiating method categories
all_categories.each do |cat|
  method_category = MethodCategory.new(name: cat)
  if method_category.save
    p "Added method category: #{method_category.name}"
  else
    p "Error while creating a method category: "
    method_category.errors.full_messages.each do |message|
      p "\t#{message}"
    end
  end
end

# Load a design method field
def load_field(data, search_property)
  to_return = ""
  search_term = SPARQL.parse("#{ROOT_PREFIX} SELECT ?obj { :#{method} :#{search_property} ?obj")
  data.query(search_term).each do |results|
    to_return _= results.obj.to_s
  end

  if to_return.empty?
    to_return = "default"
  end

  return to_return
end


# Instantiating design methods

only_methods.each do |method|
  # Load fields
  overview = load_field("Description")
  if overview == "default"
    overview = load_field("hasOverview")
  end

  process = load_field("process")
  if process == "default"
    process = load_field("hasProcess")
  end

  principle = load_field("Notes")
  if principle == "default"
    principle = load_field("hasPrinciple")
  end

  fields[:name] = method
  fields[:overview] = overview
  fields[:process] = process
  fields[:principle] = principle

  # Create new design method
  design_method = DesignMethod.new(fields)
  design_method.owner = admin

  # If created, load citations, categories, method variations
  if !design_method.save
    p "Error while creating a design method: "
    design_method.errors.full_messages.each do |message|
      p "\t#{message}"
    return
    end
  else
    p "Added design method: #{design_method.name}"
  end

  # Load citations
  citations = SPARQL.parse("#{ROOT_PREFIX} SELECT ?ref { :#{design_method.name} :references ?ref }")
  all_citations = data.query(citations)
  all_citations << << SPARQL.parse("#{ROOT_PREFIX} SELECT ?ref { :#{design_method.name} :hasReference ?ref }")
  all_citations.each do |results|
    cit_text = results.ref.to_s
    citation = Citation.where(text: cit_text).first_or_create!
    if !design_method.citations.include?(citation)
      design_method.citations << citation
      p "    Added citation #{cit_text}"
    end
  end

  # Load categories
  categories = SPARQL.parse("#{root_prefix} SELECT ?obj { :#{design_method.name} <#{RDF::RDFS.subClassOf}> ?obj }")
  data.query(categories).each do |results|
    cat_name = results.obj.to_s.split('#')[1]
    if all_categories.include?(cat_name)
      category = MethodCategory.where(name: cat_name).first
      if category && !design_method.method_categories.include?(category)
        design_method.method_categories << category
        p "    Added category #{cat_name}"
      end
    end
  end

  # Load variations
  methods = SPARQL.parse("#{root_prefix} SELECT ?subj { ?subj <#{RDF::RDFS.subClassOf}> :#{design_method.name}")
  data.query(methods).each do |results|
    var_name = results.obj.to_s.split('#')[1]
    if only_methods.include?(var_name)
      variation = DesignMethod.where(name: var_name).first
      if variation && !design_method.variations.include?(variation)
        design_method.variations << variation
        p "    Added variation #{var_name}"
      end
    end
  end
end