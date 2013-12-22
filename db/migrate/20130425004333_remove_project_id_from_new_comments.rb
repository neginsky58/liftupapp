class RemoveProjectIdFromNewComments < ActiveRecord::Migration
  def change
  	remove_index :newcomments, :column => [ :commentable_id, :commentable_type ]
  	remove_column :newcomments, :project_id
  	add_index :newcomments, [ :commentable_id, :commentable_type ]
  end
end