class PositionsController < ApiController

  def index
    if(params[:pstatus] == 'to_review')
      respond_with user.job_search.fetch.collect{|search_result| PositionFactory.build_from_search_results(search_result)}
    else
      respond_with user.positions, :include => :related_emails
    end
  end

  def create
    pos = user.positions.create(params[:position])
    respond_with user, pos, :include => :related_emails
  end

  def show
    respond_with user, user.positions.find(params[:id]), :include => :related_emails
  end

  def destroy
    position.destroy
    respond_with position
  end

  def update
    position.update_attributes(params[:position])
    respond_with user, position, :status => :ok
  end

  private

  def position
    @position ||= Position.find(params[:id])
  end
end
