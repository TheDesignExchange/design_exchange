# == Schema Information
#
# Table name: method_citations
#
#  id               :integer          not null, primary key
#  design_method_id :integer
#  citation_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class MethodCitation < ActiveRecord::Base
  attr_accessible :citation_id, :design_method_id

  belongs_to :design_method
  belongs_to :citation
end
