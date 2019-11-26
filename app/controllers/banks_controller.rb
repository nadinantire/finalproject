class BanksController < ApplicationController
    def new
    end
  
    def create
      # Check for a bank token
      if params[:stripeToken]
        token = params[:stripeToken]
  
        # Create Stripe user with token
        begin
          # If there's not a user object for the current user, create one
          # For the purpose of this demo, we're just storing a user ID in a session.
          # In a production application, you'll want to store the user in your database
          if session[:user].nil?
            user = Stripe::User.create(
              source: token,
              description: 'Bank account form example user'
            )
  
          # Replace the existing bank account for the existing user
          else
            user = Stripe::User.retrieve(session[:user])
            user.source = token
            user.save
          end
  
          # Create a session for the user and bank account ID
          session[:user] = user.id
          session[:bank_account] = user.sources.data.first.id
  
          # Redirect to verify microdeposit amounts
          flash[:success] = 'Your bank account has been connected.'
          redirect_to new_microdeposit_path
        rescue Stripe::StripeError => e
          # Too many requests made to the API too quickly
          flash[:alert] = e.message
          redirect_to new_banks_path
        end
      else
        flash[:alert] = 'No stripeToken provided'
        redirect_to new_banks_path
      end
    end
end
