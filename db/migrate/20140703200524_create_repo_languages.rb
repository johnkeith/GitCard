class CreateRepoLanguages < ActiveRecord::Migration
  def change
    create_table :repo_languages do |t|
      t.integer :repo_id, null: false
      t.integer :language_id, null: false
      t.integer :amount_in_bytes
      t.timestamps
    end
  end
end
