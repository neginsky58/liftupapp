class CreateProjectRelationships < ActiveRecord::Migration
  def change
    create_table :project_relationships do |t|
      t.integer :follower_id

      t.timestamps
    end

    add_index :project_relationships, :follower_id, unique: true
  end
end
