class PagesController < ApplicationController
  def home
  end

  def explore
  	@categories = Category.organized.page(params[:categorylist_page]).per_page(20)
  	@projectlocations = Projectlocation.organized.page(params[:projectlocationlist_page]).per_page(20)
  	@projects = Project.approved.page(params[:mainprojects_page]).per_page(4)
  end
end
