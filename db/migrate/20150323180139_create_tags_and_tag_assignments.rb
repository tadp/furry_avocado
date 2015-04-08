class CreateTagsAndTagAssignments < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
    end

    create_table :tag_assignments do |t|
      t.references :taggable, polymorphic: true
      t.integer :tag_id, null: false
    end

    add_index :tags, :name, unique: true
    add_index :tag_assignments, :taggable_id
    add_index :tag_assignments, :tag_id
    add_index :tag_assignments, [:taggable_id, :taggable_type, :tag_id], unique: true, name: "tag_assignments_on_taggable_id_and_taggable_type_and_tag_id"
  end
end
