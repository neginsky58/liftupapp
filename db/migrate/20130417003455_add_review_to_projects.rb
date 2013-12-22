class AddReviewToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :projectreview, :boolean, :default => false
  end
end
