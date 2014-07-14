class AddSocialIconColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_url, :string
    add_column :users, :twitter_url, :string
    add_column :users, :facebook_url, :string
    add_column :users, :linkedin_url, :string
    add_column :users, :personal_site_url, :string
  end
end
