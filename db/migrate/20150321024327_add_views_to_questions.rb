class AddViewsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :view_count, :integer, null: false
    add_index :questions, :view_count
  end
end
