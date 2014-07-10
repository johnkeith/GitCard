class AddDescriptionColumnToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :description, :text
  end
end
