class ChangeDefaultRepoVisibility < ActiveRecord::Migration
  def up
    change_column :repos, :profile_visibility, :boolean, :default => false
  end
  def down
    change_column :repos, :profile_visibility, :boolean, :default => true
  end
end
