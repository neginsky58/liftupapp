class CreateBlogupdates < ActiveRecord::Migration
  def change
    create_table :blogupdates do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :content

      t.timestamps
    end
  end
end
