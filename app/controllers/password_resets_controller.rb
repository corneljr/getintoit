class PasswordResetsController < ApplicationController
	skip_before_filter :require_login

  def create
  	@player = Player.find_by(email: params[:player_email])

  	if @player
  		@player.deliver_reset_password_instructions! 
  		redirect_to root_path, notice: 'Instructions have been sent to your email.'
  	else
  		flash[:error] = 'Email not found. Please create an account.'
  		redirect_to root_path
  	end
  end

  def edit
  	@token = params[:id]
  	@player = Player.load_from_reset_password_token(@token)

  	if @player.blank?
  		not_authenticated
  		return
  	end
  end

  def update
  	@token = params[:id]
  	@player = Player.load_from_reset_password_token(@token)

  	if @player.blank?
  		not_authenticated
  		return 
  	end

  	if @player.change_password!(params[:player][:password])
  		redirect_to root_path, notice: 'Password was successfully updated.'
  	else 
  		render :edit
  	end
  end
end
