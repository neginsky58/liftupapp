class CreateDonatePlans < ActiveRecord::Migration
  def change
    create_table :donate_plans do |t|
      t.decimal :amount, :precision => 10, :scale => 2      
      t.integer :user_id
      t.integer :project_id
      t.string  :project_title      
      t.decimal :setup_amount, :precision => 10, :scale => 2
      
      t.integer :trial_period, :default => 1
      t.string :trial_interval, :default => 'months'
      
      t.float :unit_price
      t.text :description
      t.boolean :featured, :default => false
      t.timestamps
    end
  end
end
