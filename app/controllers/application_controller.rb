class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login
  before_filter :set_settings
  before_filter :force_feedback

  def redirect_if_logged_in
    if current_user && !current_user.pending_feedback
      redirect_to sub_requests_path
  	end
  end

  def set_settings
    @player = current_user
    @sports = Sport.sports_with_ids
  end

  def force_feedback
    if current_user && current_user.pending_feedback
      redirect_to sub_requests_path({feedback: 'true', user: current_user.id})
    end
  end

private
	def not_authenticated
  	redirect_to root_path, alert: "Please login first"
	end
end
