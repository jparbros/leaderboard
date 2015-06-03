class Api::SubscriptionsController < ApplicationController

  def create
    @subscription = organization.subscription
    @subscription.attributes = subscription_params
    if @subscription.save
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
    params.require(:subscription).permit(:subscription_kind, credit_card_attributes: [
      :type, :first_name, :last_name, :number, :verification_value, :month, :year],
      billing_address: []
    )
  end

  def organization
    @organization ||= Organization.find params[:organization_id]
  end
end
