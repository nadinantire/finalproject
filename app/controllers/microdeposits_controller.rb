class MicrodepositsController < ApplicationController
    def new
        # Check for a user and bank account stored in a session
        # You could also retrieve this from your database, GET params, etc.
        if session[:user] && session[:bank_account]
          @user = session[:user]
          @bank_account = session[:bank_account]
        else
          flash[:alert] = "This bank account wasn't found. Please add one below"
          redirect_to new_banks_path
        end
      end
    
      def create
        # Check for a user ID and bank account ID -- needed to validate account
        # You could also retrieve this from a session or database
        if params[:user] && params[:bank_account]
          user = params[:user]
          bank_account = params[:bank_account]
    
          # Check for valid amount submissions, strip decimals and dollar signs
          if params[:amount1] && params[:amount2]
            amount1 = params[:amount1].tr('.$', '')
            amount2 = params[:amount2].tr('.$', '')
    
            # Verify the amounts
            begin
              user = Stripe::User.retrieve(user)
              bank_account = user.sources.retrieve(bank_account)
              bank_account.verify(amounts: [amount1, amount2])
    
              # Direct the user to pay
              flash[:success] = 'Your bank account has been connected.'
              redirect_to new_payment_path
            rescue Stripe::StripeError => e
              # Too many requests made to the API too quickly
              flash[:alert] = e.message
              redirect_to new_microdeposit_path
            end
          else
            flash[:alert] = 'Invalid deposit amounts entered'
            redirect_to new_microdeposit_path
          end
        else
          flash[:alert] = 'No bank account or user provided. Add a bank account to make a payment.'
          redirect_to root_path
        end
      end
end
