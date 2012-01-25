class PositionsController < ApplicationController
  def index
    logger.info "headers: #{params.inspect}"
    if params['user_id']
      @positions = User.find(params['user_id']).positions
    else
      @positions = Position.all
    end

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @positions }
    end
  end

  def new
    @position = Position.new

    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @position }
    end
  end

  def create
    @position = Position.new(params[:position])

    respond_to do |format|
      if @position.save
        format.html  { redirect_to(@position,
                      :notice => 'Position was successfully created.') }
        format.json  { render :json => @position,
                      :status => :created, :location => @position }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @position.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def show
    logger.info"params: params.inspect"
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

  def edit
    @position = Position.find(params[:id])
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
end
