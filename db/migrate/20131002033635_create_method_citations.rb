class CreateMethodCitations < ActiveRecord::Migration
  def change
    create_table :method_citations do |t|
      t.string :text

      t.timestamps
    end
  end
end
