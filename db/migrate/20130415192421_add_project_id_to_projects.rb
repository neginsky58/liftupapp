class AddProjectIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_id, :integer
    add_index :projects, :project_id
  end
end
