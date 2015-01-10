namespace :send do 
	desc 'Update the skill ratings'
	task :reminder_emails => :environment do 
		games = get_todays_games
		send_reminder_emails(games)
	end
end

def get_todays_games
	games = SubRequest.upcoming(Time.now)
	games
end

def send_reminder_emails(games)
	games.each do |game|
		sub = game.sub
		PlayerMailer.delay.reminder_email(sub, game)
	end
end