class CreateTagsAndTagAssignments < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
    end

    create_table :tag_assignments do |t|
      t.integer :question_id, null: false
      t.integer :tag_id, null: false
    end

    add_index :tags, :name, unique: true
    add_index :tag_assignmentss, :question_id
    add_index :tag_assignmentss, :tag_id
    add_index :tag_assignmentss, [:question_id, :tag_id], unique: true
  end
end
