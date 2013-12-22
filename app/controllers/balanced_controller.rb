class BalancedController < ApplicationController
  def create_balanced_account
    current_user.update_attribute(:balanced_account_uri, Balanced::Marketplace.my_marketplace.create_account(:email => current_user.email, :type => 'person').uri)
    # current_user.balanced_account_uri = Balanced::Marketplace.my_marketplace.create_account(:email => current_user.email, :type => 'person').uri
    # current_user.save
    # add a redirect to the desired path
    redirect_to edit_user_registration_path

  end
  
  def store_credit_card
    balanced_account = Balanced::Account.find(current_user.balanced_account_uri)
    balanced_account.add_card(params[:balancedCreditCardURI])
    # add a redirect to the desired path
    redirect_to edit_user_registration_path
  end
  
  def store_bank_account
    balanced_account = Balanced::Account.find(current_user.balanced_account_uri)
    balanced_account.add_card(params[:balancedBankAccountURI])
    # add a redirect to the desired path
    redirect_to root_url
  end
  
  def process_payment
    balanced_account = Balanced::Account.find(current_user.balanced_account_uri)
    account.debit(find(current_user.balanced_account_uri)
    balanced_account.add_card(params[:balancedBankAccountURI])
    # add a redirect to the desired path
      :amount => 1000, # or params[:amount]
      :description => "Balanced Payments transaction",
      :appears_on_statement_as => "Balanced Payments")
    # add a redirect to the desired path
    redirect_to root_url
  end
end
