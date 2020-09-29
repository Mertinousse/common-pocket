class ApplicationController < ActionController::Base
  before_action :authenticate
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
end
