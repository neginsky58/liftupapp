class AddProjectLocationIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :projectlocation_id, :integer
  end
end
