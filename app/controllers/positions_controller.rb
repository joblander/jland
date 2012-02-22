class PositionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  respond_to :json

  def index
    @positions = User.find(params['user_id']).positions
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @positions }
    end
  end

  def create
    user = User.find(params['user_id'])
    @position = user.positions.create(params[:position])

    respond_to do |format|
      if @position.save
        format.html  { redirect_to(@position,
                      :notice => 'Position was successfully created.') }
        format.json  { render :json => @position,
                      :status => :created, :location => user_position_url(user, @position) }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @position.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @position }
    end
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url }
      format.json { head :no_content }
    end
  end

  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        format.html  { redirect_to(@position,
                      :notice => 'Position was successfully updated.') }
        format.json  { render :json => {}, :status => :ok }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @position.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  private

  def record_not_found
      respond_with({}, :status => :not_found)
  end
end
