class Citation < ActiveRecord::Base
  attr_accessible :text

  has_many :method_citations, dependent: :destroy
  has_many :design_methods, through: :method_citations
end
