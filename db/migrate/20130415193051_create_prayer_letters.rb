class CreatePrayerLetters < ActiveRecord::Migration
  def change
    create_table :prayer_letters do |t|
      t.string :description

      t.timestamps
    end
  end
end
