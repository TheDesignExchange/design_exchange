class MethodCitation < ActiveRecord::Base
  attr_accessible :text

  has_many :citations, dependent: :destroy
  has_many :design_methods, through: :citations
end