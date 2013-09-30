class MethodCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :categorizations, dependent: :destroy
  has_many :design_methods, through: :categorizations
end
