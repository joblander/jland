class PositionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  respond_to :json

  def index
    @positions = User.find(params['user_id']).positions
    respond_with @positions
  end

  def create
    user = User.find(params['user_id'])
    @position = user.positions.create(params[:position])

    if @position.save
      respond_with @position, :status => :created, :location => user_position_url(user, @position)
    else
      respond_with @position.errors, :status => :unprocessable_entity
    end
  end

  def show
    @position = Position.find(params[:id])
    respond_with @position
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    head :no_content
  end

  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        respond_with({}, :status => :ok)
      else
        respond_with @position.errors, :status => :unprocessable_entity
      end
    end
  end

  private

  def record_not_found
      respond_with({}, :status => :not_found)
  end
end
