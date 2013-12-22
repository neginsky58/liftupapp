class DonatePlansController < ApplicationController
  before_filter :authenticate_user!
  def show
    project_id = params[:id]
    if Project.find(params[:id]).projectreviewed == true || current_user.try(:admin?) || current_user == Project.find(params[:id]).user
      @project = Project.find(params[:id])
      @commentable = @project      
    else
      redirect_to root_url
    end
  end
  def project
    
    @project_id = params[:id]    
    @donate_plan = current_user.donate_plans.find(:first, :conditions => ['project_id = ?', @project_id])    
    if Project.find(params[:id]).projectreviewed == true
      @project = Project.find(@project_id)
    end
    if @donate_plan.blank?
      @donate_plan = DonatePlans.new
    end    
  end
  def save
    
    unless params[:donate_plans].blank?
      amount = params[:donate_plans][:amount]
      setup_amount = params[:donate_plans][:setup_amount]
      amount = amount.delete(',').to_f.round(2)
      setup_amount = setup_amount.delete(',').to_f.round(2)
        
      if params[:donate_plans][:id].blank?
          project = Project.find(params[:donate_plans][:project_id])
          save_data = {
            'user_id' => current_user.id,
            'amount' => params[:donate_plans][:amount],
            'setup_amount' => params[:donate_plans][:setup_amount],
            'project_id' => params[:donate_plans][:project_id],
            'project_title' => project.projecttitle              
          }
          @donate_plan = DonatePlans.new(save_data)
          if @donate_plan.save
            flash[:notice] = "Donation plan has be saved successfully"
          end
      else
        @donate_plan = DonatePlans.find(params[:donate_plans][:id])          
        @donate_plan.update_attributes(params[:donate_plans])
        flash[:notice] = "The plan has been updated"
      end
      
    end  
    
    redirect_to :action => :index
  end
  def index
    @donate_plans = current_user.donate_plans.find(:all)  
    @projects = Project.where('projectreviewed = true and user_id != ?', current_user.id)
  end
  def delete
    donate_plan_id = params[:donate_plan_id]
    @donate_plans = DonatePlans.delete(donate_plan_id)
    flash[:notice] = "Deleted successfully"    
    redirect_to :action => 'index'
  end
   
  
end
