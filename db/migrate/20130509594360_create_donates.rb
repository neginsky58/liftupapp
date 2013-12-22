class CreateDonates < ActiveRecord::Migration
  def change
    create_table :donates do |t|
      t.integer :donator_id
      t.string :stripe_token
      t.integer :donate_plan_id
      t.decimal :amount, :precision => 10, :scale => 2
      
      t.string :state
      t.string :donator_type, :default => "User" 
      t.integer :donate_affiliate_id
      t.string :billing_id
      
      t.timestamps
    end
  end
end
