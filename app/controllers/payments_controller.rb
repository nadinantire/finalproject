class PaymentsController < ApplicationController
           def new
          # For the purpose of this demo, we're just storing a user ID in a session.
          # In a production application, you'll want to store the user in your database
          if session[:user] && session[:bank_account]
            @user = Stripe::User.retrieve(session[:user])
            @bank_account = @user.sources.retrieve(session[:bank_account])
          else
            flash[:alert] = 'Please add a bank account to make an ACH payment.'
            redirect_to root_path
          end
        end
      
        def create
          # Turn the amount into cents and strip dollar signs
          amount = (100 * params[:amount].tr('$', '').to_r).to_i
      
          # Check for a valid donation amount (the minimum charge allowed in USD is $.50)
          unless amount > 50
            flash[:alert] = 'Please enter a valid payment amount (minimum donation is $.50).'
            redirect_to new_payment_path and return
          end
      
          # Check for a user and bank account ID
          if params[:user] && params[:bank_account]
            # Create the charge on Stripe
            begin
              charge = Stripe::Charge.create(
                user: params[:user],
                source: params[:bank_account],
                amount: amount,
                currency: 'usd',
                description: 'Payment from ACH example app'
              )
      
              # Let the user know the payment was successful
              flash[:success] = "Thanks for your payment! Your transaction ID is #{charge.id}."
              redirect_to payments_path
            rescue Stripe::StripeError => e
              # Too many requests made to the API too quickly
              flash[:alert] = e.message
              redirect_to new_payment_path
            end
          else
            flash[:alert] = 'No user or bank account provided'
            redirect_to root_path
          end
        end
      
        def index
          if session[:user]
            # Retrieve all of this user's payments from Stripe
            @payments = Stripe::Charge.list(limit: 100, paid: true, user: session[:user])
          else
            flash[:alert] = 'Please add a bank account to make an ACH payment.'
            redirect_to root_path
          end
        end
      
        def show
      
        end
      
      
end
