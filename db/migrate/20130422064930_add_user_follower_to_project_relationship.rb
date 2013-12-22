class AddUserFollowerToProjectRelationship < ActiveRecord::Migration
  def change
    add_column :project_relationships, :userfollower, :integer
    add_index :project_relationships, :userfollower
  end
end
