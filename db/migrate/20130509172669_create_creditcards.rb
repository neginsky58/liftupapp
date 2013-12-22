class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.integer :user_id
      
      t.string :first_name
      t.string :last_name
      t.string :stripe_token
      t.string :stripe_customer_id
      
      t.integer :exp_year
      t.integer :exp_month
      t.string :cvv      
      
      t.timestamps
    end
  end
end
