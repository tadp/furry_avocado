class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :author_id, null: false
      t.integer :question_id, null: false
      t.text :body
      t.boolean :accepted, default: false, null: false
    end

    add_index :responses, :author_id
    add_index :responses, :question_id
    add_index :responses, :accepted
  end
end