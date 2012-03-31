class JobSearchController < ApplicationController

  def update
    @job_search = JobSearch.find(params[:id])
    if @job_search.update_attributes(params[:job_search])
      flash[:notice] = "Successfully updated job search."
    end

    respond_to do |format|
      format.html {redirect_to :back}
      format.json {render :json => @job_search}
    end
  end

  def show
  	job_search = JobSearch.find(params[:id])
  	respond_to do |format|
  		format.json {render :json => job_search}
  	end
  end
end