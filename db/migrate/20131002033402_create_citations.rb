class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.integer :method_citation_id
      t.integer :design_method_id

      t.timestamps
    end
    
    add_index :citations, [:design_method_id, :method_citation_id], unique: true, name: 'cit_index'
    add_index :citations, :design_method_id
    add_index :citations, :method_citation_id
  end
end
