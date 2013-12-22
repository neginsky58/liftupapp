class AddUserIdToProjectRelationships < ActiveRecord::Migration
  def change
    add_column :project_relationships, :projectuser_id, :integer
    add_index :project_relationships, :projectuser_id
  end
end
