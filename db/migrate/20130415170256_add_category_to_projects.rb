class AddCategoryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :category, :string
    add_index :projects, :category
  end
end
