class RemoveTablePrayerLetters < ActiveRecord::Migration
  def change
  	drop_table :prayer_letters
  end
end