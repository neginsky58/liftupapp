class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :membername
      t.integer :project_id
      t.text :content
      t.string :teamuserimage

      t.timestamps
    end
  end
end
