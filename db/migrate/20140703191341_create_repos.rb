class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.integer :user_id, null: false
      t.string  :full_name, null: false
      t.string  :name, null: false
      t.string  :html_url, null: false
      t.boolean :profile_visibility, default: true
      t.timestamps
    end
  end
end
