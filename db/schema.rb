# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150108210616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.integer  "country",                               default: 1, null: false
    t.integer  "region_id",                                         null: false
    t.string   "region_type",                                       null: false
    t.string   "name",                                              null: false
    t.decimal  "latitude",    precision: 15, scale: 10
    t.decimal  "longitude",   precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timezone",                                          null: false
  end

  add_index "cities", ["country"], name: "index_cities_on_country", using: :btree
  add_index "cities", ["region_id", "region_type"], name: "index_cities_on_region_id_and_region_type", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "divisions", force: true do |t|
    t.integer  "league_id",                null: false
    t.string   "name",                     null: false
    t.integer  "num_teams",    default: 0, null: false
    t.integer  "num_players",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id",                null: false
    t.float    "skill_rating"
    t.integer  "skill_level",              null: false
  end

  add_index "divisions", ["league_id"], name: "index_divisions_on_league_id", using: :btree

  create_table "fsas", force: true do |t|
    t.string   "label",                                 null: false
    t.decimal  "latitude",    precision: 15, scale: 10
    t.decimal  "longitude",   precision: 15, scale: 10
    t.integer  "city_id",                               null: false
    t.integer  "province_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fsas", ["label"], name: "index_fsas_on_label", using: :btree

  create_table "games", force: true do |t|
    t.integer  "sport_id",                             null: false
    t.integer  "league_id",                            null: false
    t.integer  "city_id",                              null: false
    t.integer  "venue_id",                             null: false
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.datetime "starts_at",                            null: false
    t.datetime "finishes_at",                          null: false
    t.integer  "score1",               default: 0,     null: false
    t.integer  "score2",               default: 0,     null: false
    t.boolean  "deleted",              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skill_level",                          null: false
    t.integer  "state",                default: 0,     null: false
    t.integer  "division_id"
    t.integer  "season_id",                            null: false
    t.float    "optimal_skill_rating"
  end

  add_index "games", ["league_id"], name: "index_games_on_league_id", using: :btree
  add_index "games", ["player1_id", "player2_id"], name: "index_games_on_player1_id_and_player2_id", using: :btree
  add_index "games", ["sport_id", "city_id"], name: "index_games_on_sport_id_and_city_id", using: :btree
  add_index "games", ["team1_id", "team2_id"], name: "index_games_on_team1_id_and_team2_id", using: :btree

  create_table "league_operating_cities", force: true do |t|
    t.integer  "league_id",                  null: false
    t.integer  "city_id",                    null: false
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "league_operating_cities", ["city_id"], name: "index_league_operating_cities_on_city_id", using: :btree
  add_index "league_operating_cities", ["league_id"], name: "index_league_operating_cities_on_league_id", using: :btree

  create_table "league_venues", force: true do |t|
    t.integer  "league_id",                  null: false
    t.integer  "venue_id",                   null: false
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "league_venues", ["league_id"], name: "index_league_venues_on_league_id", using: :btree
  add_index "league_venues", ["venue_id"], name: "index_league_venues_on_venue_id", using: :btree

  create_table "leagues", force: true do |t|
    t.integer  "sport_id",                         null: false
    t.string   "name",                             null: false
    t.integer  "num_teams",        default: 0,     null: false
    t.integer  "num_players",      default: 0,     null: false
    t.boolean  "deleted",          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "skill_rating"
    t.string   "feed_config_name"
  end

  add_index "leagues", ["sport_id"], name: "index_leagues_on_sport_id", using: :btree

  create_table "player_availabilities", force: true do |t|
    t.integer  "player_id"
    t.integer  "day",            null: false
    t.time     "available_from", null: false
    t.time     "available_to",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_availabilities", ["day", "available_from", "available_to"], name: "availability_search_index", using: :btree
  add_index "player_availabilities", ["player_id"], name: "index_player_availabilities_on_player_id", using: :btree

  create_table "player_cities", force: true do |t|
    t.integer  "player_id",                  null: false
    t.integer  "city_id",                    null: false
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_cities", ["city_id"], name: "index_player_cities_on_city_id", using: :btree
  add_index "player_cities", ["player_id"], name: "index_player_cities_on_player_id", using: :btree

  create_table "player_feedbacks", force: true do |t|
    t.integer "player_id",         null: false
    t.integer "league_id",         null: false
    t.integer "division_id"
    t.integer "reviewer_id",       null: false
    t.integer "fit_score"
    t.integer "skill_score"
    t.integer "punctuality_score"
    t.integer "personality_score"
  end

  create_table "player_games", force: true do |t|
    t.integer  "league_id",                  null: false
    t.integer  "player_id",                  null: false
    t.integer  "team_id"
    t.integer  "game_id",                    null: false
    t.boolean  "subbed",     default: false, null: false
    t.boolean  "deleted",    default: false, null: false
    t.boolean  "checked_in", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_games", ["game_id"], name: "index_player_games_on_game_id", using: :btree
  add_index "player_games", ["player_id"], name: "index_player_games_on_player_id", using: :btree

  create_table "player_leagues", force: true do |t|
    t.integer  "player_id",                  null: false
    t.integer  "league_id",                  null: false
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_leagues", ["league_id"], name: "index_player_leagues_on_league_id", using: :btree
  add_index "player_leagues", ["player_id"], name: "index_player_leagues_on_player_id", using: :btree

  create_table "player_sports", force: true do |t|
    t.integer  "player_id"
    t.integer  "sport_id",                 null: false
    t.boolean  "deleted"
    t.string   "position"
    t.integer  "skill_level",  default: 0, null: false
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "skill_rating",             null: false
    t.boolean  "play_coed"
  end

  add_index "player_sports", ["player_id"], name: "index_player_sports_on_player_id", using: :btree
  add_index "player_sports", ["sport_id", "skill_level"], name: "index_player_sports_on_sport_id_and_skill_level", using: :btree

  create_table "player_stats", force: true do |t|
    t.integer  "player_id",       null: false
    t.integer  "sport_id",        null: false
    t.integer  "league_id",       null: false
    t.integer  "season_id",       null: false
    t.integer  "stat_type_id",    null: false
    t.float    "stat_type_value", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_stats", ["player_id", "league_id", "season_id"], name: "index_player_stats_on_player_id_and_league_id_and_season_id", using: :btree
  add_index "player_stats", ["player_id", "sport_id"], name: "index_player_stats_on_player_id_and_sport_id", using: :btree

  create_table "player_teams", force: true do |t|
    t.integer  "player_id",                   null: false
    t.integer  "league_id",                   null: false
    t.integer  "team_id",                     null: false
    t.boolean  "deleted",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id",                   null: false
    t.integer  "division_id",                 null: false
    t.integer  "sport_id"
  end

  add_index "player_teams", ["league_id"], name: "index_player_teams_on_league_id", using: :btree
  add_index "player_teams", ["player_id"], name: "index_player_teams_on_player_id", using: :btree
  add_index "player_teams", ["team_id"], name: "index_player_teams_on_team_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "email"
    t.string   "phone_number"
    t.float    "availability_radius",             default: 30.0,  null: false
    t.text     "regions"
    t.integer  "num_games",                       default: 0,     null: false
    t.integer  "num_leagues",                     default: 0,     null: false
    t.integer  "num_subs",                        default: 0,     null: false
    t.boolean  "deleted",                         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timezone",                                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.float    "skill_rating"
    t.string   "stripe_customer_id"
    t.datetime "birth_date"
    t.string   "sex"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.float    "avg_fit_score"
    t.float    "avg_skill_score"
    t.float    "avg_punctuality_score"
    t.float    "avg_personality_score"
    t.string   "first_name"
    t.string   "last_name"
    t.float    "weighted_overall_score"
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree

  create_table "postal_codes", force: true do |t|
    t.string   "label",                                 null: false
    t.decimal  "latitude",    precision: 15, scale: 10
    t.decimal  "longitude",   precision: 15, scale: 10
    t.integer  "city_id",                               null: false
    t.integer  "province_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postal_codes", ["label"], name: "index_postal_codes_on_label", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "name",                   null: false
    t.string   "abbreviation", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["name"], name: "index_provinces_on_name", unique: true, using: :btree

  create_table "seasons", force: true do |t|
    t.integer  "league_id",  null: false
    t.datetime "starts_at",  null: false
    t.datetime "ends_at",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["league_id"], name: "index_seasons_on_league_id", using: :btree

  create_table "sport_stat_types", force: true do |t|
    t.integer  "sport_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sport_stat_types", ["sport_id"], name: "index_sport_stat_types_on_sport_id", using: :btree

  create_table "sports", force: true do |t|
    t.string   "name",                       null: false
    t.boolean  "team_sport", default: true,  null: false
    t.boolean  "deleted",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name",                   null: false
    t.string   "abbreviation", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["name"], name: "index_states_on_name", unique: true, using: :btree

  create_table "sub_requests", force: true do |t|
    t.integer  "poster_id",                        null: false
    t.integer  "team_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time",                       null: false
    t.datetime "end_time"
    t.integer  "venue_id",                         null: false
    t.integer  "sport_id",                         null: false
    t.integer  "sub_id"
    t.integer  "status",               default: 0, null: false
    t.integer  "skill_level",                      null: false
    t.integer  "city_id"
    t.integer  "day"
    t.string   "gender"
    t.integer  "opposing_team_id"
    t.float    "optimal_skill_rating"
    t.string   "venue_specific"
  end

  add_index "sub_requests", ["city_id"], name: "index_sub_requests_on_city_id", using: :btree
  add_index "sub_requests", ["poster_id"], name: "index_sub_requests_on_poster_id", using: :btree
  add_index "sub_requests", ["sport_id"], name: "index_sub_requests_on_sport_id", using: :btree
  add_index "sub_requests", ["sub_id"], name: "index_sub_requests_on_sub_id", using: :btree
  add_index "sub_requests", ["team_id"], name: "index_sub_requests_on_team_id", using: :btree
  add_index "sub_requests", ["venue_id"], name: "index_sub_requests_on_venue_id", using: :btree

  create_table "teams", force: true do |t|
    t.integer  "league_id",                    null: false
    t.string   "name",                         null: false
    t.integer  "num_players"
    t.boolean  "deleted",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "division_id"
    t.float    "skill_rating"
    t.string   "gender"
  end

  add_index "teams", ["league_id"], name: "index_teams_on_league_id", using: :btree

  create_table "venues", force: true do |t|
    t.integer  "country",                               null: false
    t.integer  "city_id",                               null: false
    t.integer  "province_id",                           null: false
    t.string   "name",                                  null: false
    t.decimal  "latitude",    precision: 15, scale: 10
    t.decimal  "longitude",   precision: 15, scale: 10
    t.string   "address",                               null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["city_id"], name: "index_venues_on_city_id", using: :btree
  add_index "venues", ["name"], name: "index_venues_on_name", using: :btree

  create_table "zip_codes", force: true do |t|
    t.integer  "zip_scf_id",                           null: false
    t.integer  "zip_code",                             null: false
    t.decimal  "latitude",   precision: 15, scale: 10
    t.decimal  "longitude",  precision: 15, scale: 10
    t.integer  "city_id",                              null: false
    t.integer  "state_id",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zip_codes", ["zip_code"], name: "index_zip_codes_on_zip_code", using: :btree
  add_index "zip_codes", ["zip_scf_id"], name: "index_zip_codes_on_zip_scf_id", using: :btree

  create_table "zip_scfs", force: true do |t|
    t.integer  "state_id",   null: false
    t.integer  "scf",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zip_scfs", ["scf"], name: "index_zip_scfs_on_scf", using: :btree
  add_index "zip_scfs", ["state_id"], name: "index_zip_scfs_on_state_id", using: :btree

end
