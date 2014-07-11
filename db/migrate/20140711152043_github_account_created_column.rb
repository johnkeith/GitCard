class GithubAccountCreatedColumn < ActiveRecord::Migration
  def change
    add_column :users, :gh_account_created, :string, null: false
  end
end
