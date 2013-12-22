class ChangeAboutUserToNoLimitText < ActiveRecord::Migration
  def change
  	change_column :users, :aboutuser, :text, :limit => nil
  end

end
