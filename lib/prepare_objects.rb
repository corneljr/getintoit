module PrepareObjects
	def prepare_availabilities(user_id)
		days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun']
    avails = []
    player = Player.find(user_id)

    player.availabilities.each do |avail|
      hash = {}
      hash[:day] = days[avail.day - 1]
      hash[:section] = Availability.section(avail.available_from.strftime("%H"))
      hash[:from] = avail.available_from.strftime("%H:%M:%S")
      hash[:to] = avail.available_to.strftime("%H:%M:%S")
      avails.push(hash)
    end

    avails.to_json
	end

	def prepare_sports(user_id)
		sports = []
    player = Player.find(user_id)

    player.player_sports.each do |player_sport|
      hash = {}
      hash[:sport] = player_sport.sport.name.split(' ').join('_')
      hash[:sport_id] = player_sport.sport.id
      hash[:skill] = player_sport.skill_level
      hash[:play_coed] = player_sport.play_coed
      sports.push(hash)
    end

    sports.to_json
	end
end