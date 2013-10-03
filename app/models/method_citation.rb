class MethodCitation < ActiveRecord::Base
  attr_accessible :citation_id, :design_method_id

  belongs_to :design_method
  belongs_to :citation
end
