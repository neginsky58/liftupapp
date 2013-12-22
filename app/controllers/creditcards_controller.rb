class CreditcardsController < ApplicationController
  #before_filter :authenticate_user!
  def view_creditcards
      
    @creditcards = current_user.creditcards.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creditcards }
    end
  end
  
  # GET /projects/new
  # GET /projects/new.json
  def create_creditcard
    
    @creditcard = Creditcards.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creditcard }
    end
  end
  # POST /projects
  # POST /projects.json
  def save_creditcard
       
    save_data = params[:creditcards]
    
    save_data[:user_id] = current_user.id
    Stripe.api_key = STRIPE_SECRET_KEY
    @stripe_customer = Stripe::Customer.create(
      :card => params[:creditcards][:stripe_token],
      :description => 'Customer for test ' + current_user.email
    )
    save_data[:stripe_customer_id] = @stripe_customer.id
    @creditcard = Creditcards.new(save_data)
    
    respond_to do |format|
      if @creditcard.save
        format.html { redirect_to view_creditcards_path, notice: 'Your credit card information has been registered to Stripe' }
        # if params[:project][:image].blank?
        #   redirect_to @project
        # else
        #   render :action => "crop"
        # end

        format.json { render json: @creditcard, status: :created, location: @creditcard }
      else        
        format.html { render action: "index" }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    
  end
  # PUT /projects/1
  # PUT /projects/1.json
  def update
    
    @creditcard = Creditcard.find(params[:id])
    
    respond_to do |format|
      if @creditcard.update_attributes(params[:creditcard])
        format.html { redirect_to edit_project_path(@creditcard) }

        # if params[:project][:image].blank?
        #   redirect_to @project
        # else
        #   render :action => "crop"
        # end
        
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
    @project = current_user.projects.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end
end
