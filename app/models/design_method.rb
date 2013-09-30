class DesignMethod < ActiveRecord::Base
  searchable do
    text :name, :overview, :principle, :process
    text :method_categories do
      method_categories.map { |method_category| method_category.name }
    end
  end

  attr_accessible :name, :overview, :principle, :process

  has_many :categorizations, dependent: :destroy
  has_many :method_categories, through: :categorizations
end
