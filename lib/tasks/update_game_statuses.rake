namespace :update do 
	desc 'Update the statuses of games that were played in the last day'
	task :game_statuses => :environment do 
		update_game_statuses
	end
end

def update_game_statuses
	sub_requests = SubRequest.recently_ended
	sub_requests.each do |sub_request|
		puts "Updating #{sub_request.team.name} game"
		sub_request.update(status: 2)
	end
end