class DonatesController < ApplicationController
  
  def show
    @donates = Donates.find(params[:id])    
  end
  def index        
    @donates = Donates.where('donator_id = ?', current_user.id)        
  end
  def plan
    plan_id = params[:id]
    @donate_plan = current_user.donate_plans.find(plan_id)
    unless @donate_plan.blank?
      unless @donate_plan.user_id == current_user.id
        @donate_plan = nil
      end 
    end
    @creditcards = Creditcards.find(:all, :conditions => {:user_id => current_user.id})
            
  end
  
  def charge
    unless params[:donate_plan_id].blank?
      if params[:creditcard_id].blank?
        flash[:error] = "You need to choose the payment method."
        
      else
        begin
          @creditcard = Creditcards.find(params[:creditcard_id])
          @donate_plan = DonatePlans.find(params[:donate_plan_id])
          @project = Project.find(@donate_plan.project_id)
          
          #Stripe.api_key = "sk_test_apo6Kp3hYCboJvVo3XqQ1gu5" 
          project_creator_id = @project.user_id
          account = Accounts.find(:first, :conditions => { :user_id => project_creator_id })
            
          project_creator_access_token = account.access_token
          #project_creator_access_token = account.stripe_user_id
          
          amount = (@donate_plan.amount.round(2) * 100).to_i() 

          #$cu = Stripe::Customer
          #$cu->card = $token;
          app_fee = get_app_fee(@donate_plan.setup_amount) * 100
          app_fee = app_fee.to_i() 
          
          # Create a Token from the existing customer on the application's account
          # shared_token = Stripe::Token.create(
            # {:customer => @creditcard.stripe_customer_id},
            # project_creator_access_token
          # )
          
          # Create a Token from the existing customer on the application's account
          # @shared_token = Stripe::Token.create(
            # {:customer => @creditcard.stripe_customer_id},
            # project_creator_access_token
          # )
          Stripe.api_key = project_creator_access_token
          @shared_token = Stripe::Token.create(
            :customer => @creditcard.stripe_customer_id
          )
                    
          # @charge = Stripe::Charge.create({
            # :amount => amount, # amount in cents, again
            # :currency => "usd",  
            # :application_fee => app_fee, #get_fee(amount)                     
            # :card => @shared_token.id            
            # },
            # project_creator_access_token            
          # )
          @charge = Stripe::Charge.create(
            :amount => amount, # amount in cents, again
            :currency => "usd",  
            :application_fee => app_fee, #get_fee(amount)                     
            :card => @shared_token.id
          )          
          
          if @charge.paid
            @donate_plan = DonatePlans.find(params[:donate_plan_id])
            donator_id = @donate_plan.user_id            
            save_data = {
              'donator_id' => donator_id,
              'project_id' => @donate_plan.project_id,
              'stripe_token' => @creditcard.stripe_customer_id,
              'donate_plan_id' => params[:donate_plan_id],
              'amount' => @donate_plan.amount,
              'donator_type' => 'User'           
            }
            @donate = Donates.new(save_data)
            @donate.save
            
            payment_data = {
              'donator_id' => donator_id,
              'transaction_id' => @charge.id,
              'amount' => (@charge.amount/100).round(2)              
            }
            @donate_payment = DonatePayments.new(payment_data)
            @donate_payment.save
            
            flash[:notice] = 'You have donated $' + (@charge.amount/100).round(2).to_s() + ' successfully!' 
          else
            flash[:error] = @charge.failure_message
          end
        rescue Stripe::CardError => e
          flash[:error] = e.message
        end        
        
      end
    else
      flash[:error] = 'Not available plan id'
    end
    
  end
  def get_app_fee(amount)
    app_fee = amount*0.02
    app_fee = app_fee.round(2)
    return app_fee
  end
  def get_fee(setup_amount)
    fee = (setup_amount + 0.30)/0.971 - setup_amount
    fee = fee.round(2)    
    return fee
  end
end
