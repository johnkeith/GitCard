class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :provider, null: false
      t.string  :uid, null: false
      t.string  :username, null: false
      t.string  :email, null: false
      t.string  :avatar_url, null: false
      t.string  :access_token, null: false
      t.boolean :profile_created, default: false
      t.timestamps
    end

    add_index :users, [:uid, :username], unique: true
  end
end

