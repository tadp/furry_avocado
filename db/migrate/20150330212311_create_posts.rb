class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
    end

    add_index :posts, :title
    add_index :posts, :body
  end
end
