class AddProjectimageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :projectimage, :string
  end
end
