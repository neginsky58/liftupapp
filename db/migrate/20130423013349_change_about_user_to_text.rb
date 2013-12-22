class ChangeAboutUserToText < ActiveRecord::Migration
  def change
  	change_column :users, :aboutuser, :text
  end

end
