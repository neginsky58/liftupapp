class ChangeAttributeToProjectRelationships < ActiveRecord::Migration
  def up
  	remove_index :project_relationships, :follower_id
  end

  def down
  	add_index :project_relationships, :follower_id
  end
end
