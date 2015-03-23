class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :question_id, null: false
      t.integer :voter_id, null: false
      t.boolean :up?, null: false
    end

    add_index :votes, :question_id
    add_index :votes, :voter_id
    add_index :votes, [:question_id, :voter_id], unique: true
  end
end
