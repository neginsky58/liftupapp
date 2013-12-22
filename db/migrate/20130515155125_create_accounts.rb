class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :stripe_user_id
      t.string :refresh_token      
      t.string :access_token
      
      t.string :scope
      t.string :stripe_publishable_key
      
      t.timestamps
    end
  end
end
