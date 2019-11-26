class TransactionController < ApplicationController
    before_action :authenticate_user!
    def index
        @user=current_user.email
    end
    def new_card
        respond_to do |format|
          format.js
        end
      end
      def create_card 
        respond_to do |format|
          if current_user.stripe_id.nil?
            user = Stripe::User.create({"email": current_user.email}) 
            #here we are creating a stripe user with the help of the Stripe library and pass as parameter email. 
            current_user.update(:stripe_id => user.id)
            #we are updating current_user and giving to it stripe_id which is equal to id of user on Stripe
          end
    
          card_token = params[:stripeToken]
          #it's the stripeToken that we added in the hidden input
          if card_token.nil?
            format.html { redirect_to transaction_path, error: "Oops"}
          end
          #checking if a card was giving.
    
          user = Stripe::user.new current_user.stripe_id
          user.source = card_token
          #we're attaching the card to the stripe user
          user.save
    
          format.html { redirect_to success_path }
        end
      end
      def success
        @plans = Stripe::Plan.list.data
      end
      def subscribe
        if current_user.stripe_id.nil?
          redirect_to success_path, :flash => {:error => 'Firstly you need to enter your card'}
          return
        end
        #if there is no card
  
        user = Stripe::User.new current_user.stripe_id
        #we define our user
  
        subscriptions = Stripe::Subscription.list(user: user.id)
        subscriptions.each do |subscription|
          subscription.delete
        end
        #we delete all subscription that the user has. We do this because we don't want that our user to have multiple subscriptions
  
        plan_id = params[:plan_id]
        subscription = Stripe::Subscription.create({
                                                       user: user,
                                                       items: [{plan: plan_id}], })
        #we are creating a new subscription with the plan_id we took from our form

      subscription.save
      redirect_to success_path
  end
end
