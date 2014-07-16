class CreateDesignMethods < ActiveRecord::Migration
  def change
    create_table :design_methods do |t|
      t.string :name, null: false
      t.text :overview, null: false
      t.text :process, null: false
      t.text :principle, null: false

      t.integer :owner_id, null: false
      t.integer :parent_id

      t.integer :num_of_designers
      t.integer :num_of_users
      t.integer :time_period
      t.string  :time_unit
      t.string  :main_image

      t.timestamps
    end
  end
end
