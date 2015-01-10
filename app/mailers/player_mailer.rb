class PlayerMailer < ActionMailer::Base
  default from: "\"Subzie\" <info@subzie.com>"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: 'Welcome to Subzie')
  end

  def sub_in_email(user, sub_request)
  	@user = user
  	@sub_request = sub_request
  	mail(to: @user.email, subject: "You've Subbed into a Game!")
  end

  def filled_sub_email(user, sub_request)
  	@user = user
  	@sub_request = sub_request
  	mail(to: @user.email, subject: "Your Sub Request has been filled!")
  end

  def reminder_email(user, sub_request)
    @user = user
    @sub_request = sub_request
    mail(to: @user.email, subject: "Don't forget about your game today!")
  end

  def reset_password_email(player)
    @player = player
    @url = edit_password_reset_url(player.reset_password_token)
    mail(to: player.email, subject: 'Subzie Password Reset')
  end
end
