class CreateNewcomments < ActiveRecord::Migration
  def change
    create_table :newcomments do |t|
      t.text :content
      t.belongs_to :commentable, polymorphic: true

      t.integer :user_id

      t.timestamps
    end

    add_index :newcomments, [:commentable_id, :commentable_type]
    add_index :newcomments, [:user_id, :created_at]

  end
end