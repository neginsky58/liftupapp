class CreateTtwocomments < ActiveRecord::Migration
  def change
    create_table :ttwocomments do |t|
      t.integer :user_id
      t.integer :newcomment_id
      t.text :content

      t.timestamps
    end
  end
end
