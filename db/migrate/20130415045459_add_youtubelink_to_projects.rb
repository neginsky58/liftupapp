class AddYoutubelinkToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :youtubelink, :string
  end
end
