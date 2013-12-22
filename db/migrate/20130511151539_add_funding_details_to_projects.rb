class AddFundingDetailsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :goal, :decimal, :precision => 10, :scale => 2
    add_column :projects, :funding_period, :integer, :default => 60
    add_column :projects, :pending_started_on, :datetime
  end
end
