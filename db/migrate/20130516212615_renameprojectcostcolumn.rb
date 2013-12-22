class Renameprojectcostcolumn < ActiveRecord::Migration
  def change
    rename_column :projectcosts, :type, :category
  end
end
