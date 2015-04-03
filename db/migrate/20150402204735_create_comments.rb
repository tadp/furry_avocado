class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.integer :commenter_id, null: false
      t.text :body, null: false
    end

    add_index :comments, :commentable_id
    add_index :comments, :commenter_id
  end
end
