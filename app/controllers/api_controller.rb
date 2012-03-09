class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  respond_to :json

  private

  def record_not_found
    respond_with({}, :status => :not_found, :location => nil)
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def position
    @position ||= Position.find(params[:position_id])
  end
end