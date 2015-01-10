class Player::Feedback < ActiveRecord::Base
  belongs_to :player
  belongs_to :reviewer,
    :class_name => 'Player',
    :foreign_key => :reviewer_id
  belongs_to :sub_request
  belongs_to :league, :inverse_of => :feedbacks
  belongs_to :division,
    :class_name => "League::Division",
    :inverse_of => :feedbacks

  # Values that determine how players will be sorted if manny players are
  # matched with a particular sub request.
  FIT_WEIGHT   = 0.5
  PUNC_WEIGHT  = 1.0
  SKILL_WEIGHT = 0.8
  PERS_WEIGHT  = 1.0

  # Dynamic programming to simulate enums with the different feedback levels
  # (you should pass in things like "fit_score => :terrible" to an update_attribute
  # call for any of these attributes)
  %w(fit_score skill_score punctuality_score personality_score).each do |score|
    define_method(score.to_sym) do
      FeedbackLevel.all[read_attribute(score.to_sym).to_i]
    end

    define_method("#{score}=") do |value|
      write_attribute(score.to_sym, FeedbackLevel.all.index(value))
    end
  end
end
