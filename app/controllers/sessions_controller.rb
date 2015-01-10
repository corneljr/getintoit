class SessionsController < ApplicationController
  before_filter :redirect_if_logged_in, only: [:new, :create]
	skip_before_filter :require_login, only: [:new, :create, :forgot_password]
  layout 'login', only: [:new, :forgot_password]

  def new
  end

  def create
  	if @player = login(params[:email], params[:password])
      if @player.pending_feedback
        redirect_to sub_requests_path({feedback: 'true', user: current_user.id})
      else
        flash[:success] = 'Login Successful.'
    		redirect_to sub_requests_path
      end
  	else
  		flash.now[:alert] = 'Invalid email/password'
  		render :new
  	end
  end

  def destroy
  	logout
  	redirect_to root_path, notice: 'Logged out.'
  end

  def forgot_password
  end
end
