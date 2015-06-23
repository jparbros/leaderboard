class Api::SubscriptionsController < ApplicationController

  def create
    @subscription = organization.subscription
    @subscription.attributes = subscription_params
    if @subscription.save
      @subscription.subscribe
      render json: @subscription
    else
      render json: @subscription
    end
  end

  def show
    @subscription = organization.subscription
    respond_with @subscription
  end

  private

  def subscription_params
    params.require(:subscription).permit(:subscription_kind, :card_number, :card_type, :token)
  end

  def organization
    @organization ||= Organization.find params[:organization_id]
  end
end
