class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  # Prevent Not Authorized Error
  rescue_from Pundit::NotAuthorizedError, with: :pundit_not_authorized

  protected

  def layout_by_resource
    devise_controller? ? 'login' : 'application'
  end

  def pundit_not_authorized
    redirect_to '/403'
  end
end
