class ApplicationController < ActionController::Base
  before_action :authenticate, :set_action_cable_identifier
  helper_method :current_user

  def current_user
    @current_user
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.find_by(name: username)
    end
  end

  def set_action_cable_identifier
    cookies.encrypted[:user_id] = current_user.id
  end
end
