class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :content, null: false
    end

    add_index :tags, :content, unique: true
  end
end
