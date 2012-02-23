class PositionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  respond_to :json

  def index
    respond_with user.positions
  end

  def create
    @position = user.positions.create(params[:position])

    if @position.save
      respond_with @position, :status => :created, :location => user_position_url(user, @position)
    else
      respond_with @position, :status => :unprocessable_entity
    end

  end

  def show
    respond_with user.positions.find(params[:id])
  end

  def destroy
    position.destroy
    head :no_content
  end

  def update
    begin
      position.update_attributes(params[:position])
      respond_with(position, :status => :ok)
    rescue ActiveRecord::UnknownAttributeError => e
      render(:json => e.message, :status => :unprocessable_entity)
      #respond_with @position, e.message, :status => :unprocessable_entity
    end
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
