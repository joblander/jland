class JobSearchController < ApplicationController

  def update
    @job_search = JobSearch.find(params[:id])
    if @job_search.update_attributes(params[:job_search])
      flash[:notice] = "Successfully updated job search."
    end
    redirect_to :back
  end
end