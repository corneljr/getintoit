class Team < ActiveRecord::Base
  belongs_to :league, 
  	foreign_key: 'league_id'
  belongs_to :division
  has_many :player_teams
  has_many :players, :through => :player_teams
  has_many :sub_requests

  validates :name, :league_id, :presence => true

  def self.organization_array
  	array = []
  	Team.all.each do |team|
  		hash = {}
  		hash[:value] = team.name
      hash[:team_id] = team.id
  		hash[:division] = team.division.name
      hash[:division_id] = team.division.id
  		hash[:league] = team.league.name
      hash[:league_id] = team.league.id
  		array.push(hash)
  	end

  	array.to_json
  end
end
