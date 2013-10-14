class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.string :user_session_id, :null => false
      t.text :data
      t.timestamps
    end
    
    add_index :user_sessions, :user_session_id
    add_index :user_sessions, :updated_at
  end
end
