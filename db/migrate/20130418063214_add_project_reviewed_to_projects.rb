class AddProjectReviewedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :projectreviewed, :boolean, :default => false
  end
end
