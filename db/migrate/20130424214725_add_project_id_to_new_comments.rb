class AddProjectIdToNewComments < ActiveRecord::Migration
  def change
  	add_column :newcomments, :project_id, :integer
  end
end
