class AddAboutUserToUser < ActiveRecord::Migration
  def change
    add_column :users, :aboutuser, :text
  end
end
