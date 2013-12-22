class RemoveProjectReviewFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :projectreview
  end
end
