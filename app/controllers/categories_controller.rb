class CategoriesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def create
    if current_user.try(:admin?)
      @category = Category.new(params[:category])
      if @category.save
        redirect_to categoryadmin_path, :notice => "Successfully created a category."
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  def admin
    if current_user.try(:admin?)
      @category = Category.new
      @categories = Category.organized.page(params[:page]).per_page(20)
    else
      redirect_to root_url
    end
  end

  def index
    if current_user.try(:admin?)
      @categories = Category.organized.page(params[:page]).per_page(20)
      @projects = Project.approved.page(params[:page]).per_page(10)
      @projectlocations = Projectlocation.organized.page(params[:page]).per_page(20)
    else
      redirect_to root_url
    end
  end

  def destroy
    if current_user.try(:admin?)
      @category = Category.find(params[:id])
      @category.destroy

      respond_to do |format|
        format.html { redirect_to categories_url }
        format.json { head :no_content }
      end
    else
      redirect_to root_url
    end
  end

  def edit
    if current_user.try(:admin?)
      @category = Category.find(params[:id])
    else
      redirect_to root_url
    end
  end

  def update
    if current_user.try(:admin?)
      @category = Category.find(params[:id])

      respond_to do |format|
        if @category.update_attributes(params[:category])
          format.html { redirect_to categoryadmin_path, notice: 'Category was successfully updated.' }  
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  def show
    @category = Category.find(params[:id])
    @projects = @category.projects.approved.page(params[:page]).per_page(20)
    @categories = Category.organized.all
    @projectlocations = Projectlocation.organized.page(params[:page]).per_page(20)
  end
  
end