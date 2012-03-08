class PositionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  respond_to :json

  def index
    respond_with user.positions, :include => :related_emails
  end

  def create
    # we're using @position in case we would want to use it in the view in the future.
    @position = user.positions.build(params[:position])
    @position.save
    respond_with user, @position, :include => :related_emails
  end

  def show
    respond_with user, user.positions.find(params[:id]), :include => :related_emails
  end

  def destroy
    position.destroy
    head :no_content
  end

  def update
    position.update_attributes(params[:position])
    respond_with(user, position, :status => :ok)
  end

  private

  def position
    @position ||= Position.find(params[:id])
  end

  def user
    @user ||= User.find(params['user_id'])
  end

  def record_not_found
    respond_with({}, :status => :not_found, :location => nil)
  end
end
