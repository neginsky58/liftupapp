class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :projecttitle
      t.string :projectshortdesc

      t.timestamps
    end
  end
end
