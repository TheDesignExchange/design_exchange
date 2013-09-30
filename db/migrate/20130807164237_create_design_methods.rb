class CreateDesignMethods < ActiveRecord::Migration
  def change
    create_table :design_methods do |t|
      t.string :name
      t.text :overview
      t.text :process
      t.text :principle

      t.timestamps
    end
  end
end
