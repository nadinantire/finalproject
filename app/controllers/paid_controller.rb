class PaidController < ApplicationController
    def new

    end
  
    def create
      # If a plaid token is submitted, request a bank token
      if params[:public_token] && params[:account_id]
        public_token = params[:public_token]
        account_id = params[:account_id]
  
        client = Plaid::Client.new(env: :sandbox,
          client_id: ENV['PLAID_CLIENT_ID'],
          secret: ENV['PLAID_SECRET'],
          public_key: ENV['PLAID_PUBLIC_KEY']
        )
  
        # Get the Stripe bank token from Plaid
        exchange_token_response = client.item.public_token.exchange(public_token)
        access_token = exchange_token_response['access_token']
  
        stripe_response = client.processor.stripe.bank_account_token.create(access_token, account_id)
        bank_account_token = stripe_response['stripe_bank_account_token']
  
  
        # Create Stripe user with token
        begin
          user = Stripe::User.create(
            source: bank_account_token,
            description: 'Plaid example user',
            metadata: { 'plaid_account' => account_id }
          )
  
          # Create sessions for the user and bank account
          # For the purpose of this demo, we're just storing a user ID in a session.
          # In a production application, you'll want to store the user ID in your database
          session[:user] = user.id
          session[:bank_account] = user.sources.data.first.id
  
          # Direct the user to pay
          flash[:success] = 'Your bank account has been connected.'
          redirect_to new_payment_path
        rescue Stripe::StripeError => e
          # Display a very generic error to the user, and maybe send
          # yourself an email
          flash[:alert] = e.message
          render 'new'
        rescue => e
          # Something else happened, completely unrelated to Stripe
          flash[:alert] = e.message
          render 'new'
        end
      else
        flash[:alert] = 'No Plaid token provided'
        render 'new'
      end
  
    end
end
