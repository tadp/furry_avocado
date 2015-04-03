class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true
      t.integer :voter_id, null: false
      t.boolean :upvoted, null: false
    end

    add_index :votes, :voteable_id
    add_index :votes, :voter_id
    add_index :votes, [:voteable_id, :voteable_type, :voter_id], unique: true
  end
end
