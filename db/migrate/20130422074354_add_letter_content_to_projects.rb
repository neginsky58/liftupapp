class AddLetterContentToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :projectletter, :text
  end
end
