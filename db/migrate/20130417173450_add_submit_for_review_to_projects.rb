class AddSubmitForReviewToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :submitreview, :boolean, :default => false
  end
end
