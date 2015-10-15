ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'tilt/erb'

class Minitest::Test
  def teardown
    Robots.delete_all
  end

  def generate_robots(num)
    num.times do |i|
      Robots.create({:name => "robbie#{i}",
                     :city => "Denver#{i}",
                     :state => "CO",
                     :avatar => "https://robohash.org/robbie#{i}.png",
                     :birthdate => "07/24/19#{i}7",
                     :date_hired => "10/15/20#{i}5",
                     :department => "IT#{i}",
                     })
    end
  end
end

Capybara.app = RobotsApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
