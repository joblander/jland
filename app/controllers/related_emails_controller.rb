class RelatedEmailsController < ApplicationController
  respond_to :json

  def create
    @related_email = position.related_emails.create(params[:related_email])
    respond_with user, position, @related_email
  end

  def destroy
    related_email.destroy
    head :no_content
  end

  private

  def position
    @position ||= Position.find(params[:position_id])
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def related_email
    @related_email ||= RelatedEmail.find(params[:id])
  end
end
