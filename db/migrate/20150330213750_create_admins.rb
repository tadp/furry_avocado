class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
    end

    add_index :admins, :username, unique: true
    add_index :admins, :email, unique: true
    add_index :admins, :session_token, unique: true
  end
end
