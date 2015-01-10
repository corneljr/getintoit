class Player::Stat < ActiveRecord::Base
  belongs_to :player
  belongs_to :sport
  belongs_to :season
  belongs_to :stat_type,
    :class_name => 'Sport::StatType',
    :foreign_key => :stat_type_id
end
