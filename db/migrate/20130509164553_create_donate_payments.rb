class CreateDonatePayments < ActiveRecord::Migration
  def change
    create_table :donate_payments do |t|
      t.integer :donator_id
      t.integer :donate_id
      t.decimal :amount, :precision => 10, :scale => 2
      t.string :transaction_id
      t.boolean :setup
      t.boolean :misc  
      t.integer :donate_affiliate_id    
      t.decimal :affiliate_amount, :precision => 10, :scale => 2
      t.string :donator_type, :default => "User" 
      
      t.timestamps
    end
  end
end
