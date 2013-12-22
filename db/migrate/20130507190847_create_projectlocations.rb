class CreateProjectlocations < ActiveRecord::Migration
  def change
    create_table :projectlocations do |t|
      t.string :location

      t.timestamps
    end
  end
end
