class AddProjectIdToDonates < ActiveRecord::Migration
  def change
    add_column :donates, :project_id, :integer
  end
end

