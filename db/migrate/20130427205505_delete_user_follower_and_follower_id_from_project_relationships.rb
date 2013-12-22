class DeleteUserFollowerAndFollowerIdFromProjectRelationships < ActiveRecord::Migration
  def change
  	remove_index :project_relationships, :column => ["follower_id", "followed_id"]
  	remove_index :project_relationships, :column => ["followed_id"]
  	remove_index :project_relationships, :column => ["userfollower"]
  	remove_column :project_relationships, :userfollower
  	remove_column :project_relationships, :followed_id
  end
end