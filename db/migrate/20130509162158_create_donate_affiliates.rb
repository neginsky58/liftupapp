class CreateDonateAffiliates < ActiveRecord::Migration
  def change
    create_table :donate_affiliates do |t|
      t.string :name
      t.decimal :rate, :precision => 10, :scale => 2
      t.string :token
      
      t.timestamps
    end
  end
end
