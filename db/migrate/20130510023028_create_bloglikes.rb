class CreateBloglikes < ActiveRecord::Migration
  def change
    create_table :bloglikes do |t|
      t.integer :user_id
      t.integer :blogupdate_id

      t.timestamps
    end

    add_index :bloglikes, :user_id
    add_index :bloglikes, :blogupdate_id
    add_index :bloglikes, [:user_id, :blogupdate_id], unique: true

  end
end