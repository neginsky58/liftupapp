class CreateProjectcosts < ActiveRecord::Migration
  def change
    create_table :projectcosts do |t|
      t.text :type
      t.integer :costestimate
      t.integer :costactual
      t.integer :project_id

      t.timestamps
    end
  end
end
