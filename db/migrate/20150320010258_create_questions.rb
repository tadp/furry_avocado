class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :author_id, null: false
      t.string :title, null: false
      t.text :body
      t.integer :vote_rating, null: false
    end

    add_index :questions, :author_id
    add_index :questions, :title
    add_index :questions, :vote_rating
  end
end