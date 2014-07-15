class ChangeProfileVisibility < ActiveRecord::Migration
  def up
    remove_column :repos, :profile_visibility, :boolean
    add_column :repos, :profile_visibility, :boolean, null: false, default: false
  end

  def down
    remove_column :repos, :profile_visibility, :boolean
    add_column :repos, :profile_visibility, :boolean, default: false
  end
end
