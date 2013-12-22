class ProjectlocationsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def create
    if current_user.try(:admin?)
      @projectlocation = Projectlocation.new(params[:projectlocation])
      if @projectlocation.save
        redirect_to projectlocationadmin_path, :notice => "Successfully created a category."
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  def admin
    if current_user.try(:admin?)
      @projectlocation = Projectlocation.new
      @projectlocations = Projectlocation.organized.page(params[:page]).per_page(20)
    else
      redirect_to root_url
    end
  end

  def index
    if current_user.try(:admin?)
      @categories = Category.organized.page(params[:page]).per_page(20)
      @projectlocations = Projectlocation.organized.page(params[:page]).per_page(20)
      @projects = Project.approved.page(params[:page]).per_page(10)
    else
      redirect_to root_url
    end
  end

  def destroy
    if current_user.try(:admin?)
      @projectlocation = Projectlocation.find(params[:id])
      @projectlocation.destroy

      respond_to do |format|
        format.html { redirect_to projectlocationadmin_url }
        format.json { head :no_content }
      end
    else
      redirect_to root_url
    end
  end

  def edit
    if current_user.try(:admin?)
      @projectlocation = Projectlocation.find(params[:id])
    else
      redirect_to root_url
    end
  end

  def update
    if current_user.try(:admin?)
      @projectlocation = Projectlocation.find(params[:id])

      respond_to do |format|
        if @projectlocation.update_attributes(params[:projectlocation])
          format.html { redirect_to projectlocationadmin_path, notice: 'Category was successfully updated.' }  
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @projectlocation.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  def show
    @projectlocation = Projectlocation.find(params[:id])
    @projects = @projectlocation.projects.approved.page(params[:page]).per_page(20)
    @projectlocations = Projectlocation.organized.all
    @categories = Category.organized.page(params[:page]).per_page(20)
  end
  
end