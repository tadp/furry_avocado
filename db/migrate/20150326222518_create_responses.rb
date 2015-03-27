class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :author_id, null: false
      t.integer :question_id, null: false
      t.text :body
    end

    add_index :responses, :author_id
    add_index :responses, :question_id
  end
end
