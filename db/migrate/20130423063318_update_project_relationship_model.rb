class UpdateProjectRelationshipModel < ActiveRecord::Migration
  def change
    add_column :project_relationships, :followed_id, :integer

    add_index :project_relationships, :followed_id
    add_index :project_relationships, [:follower_id, :followed_id], unique: true
  end
end