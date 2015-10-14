require 'yaml/store'
require_relative 'robot'

class Robots
  def self.database
    @database ||= YAML::Store.new("db/robots")
  end

  def self.create(data)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'],
                              "name" => data[:name],
                              "city" => data[:city],
                              "state" => data[:state],
                              "avatar" => "https://robohash.org/#{data[:name]}.png",
                              "birthdate" => data[:birthdate],
                              "date_hired" => data[:date_hired],
                              "department" => data[:department]
                             }
    end
  end

  def self.raw_data
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    raw_data.map { |data| Robot.new(data) }
  end

  def self.raw_robot(id)
    raw_data.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.edit(id, robot)
    database.transaction do
      target = database['robots'].find { |robot| robot["id"] == id }
      target['name']       = robot[:name]
      target['city']       = robot[:city]
      target['state']      = robot[:state]
      target['birthdate']  = robot[:birthdate]
      target['date_hired'] = robot[:date_hired]
      target['department'] = robot[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end

  def self.average_age
    ages = all.map { |robot| robot.age }
    (ages.reduce(0, :+).to_f / ages.size)
  end

  def self.hired_robots_by_year
    by_year = {}
    years = all.map { |robot| robot.date_hired.split('/')[2] }.uniq.sort
    years.each do |year|
      by_year[year] = 0
      all.each do |robot|
        by_year[year] += 1 if robot.date_hired.split('/')[2] == year
      end
    end
    by_year
  end

  def self.robots_by_department
    by_department = {}
    departments = all.map { |robot| robot.department }.uniq
    departments.each do |department|
      by_department[department.upcase] = 0
      all.each do |robot|
        by_department[department.upcase] += 1 if robot.department == department
      end
    end
    by_department
  end

  def self.robots_by_city
    by_city = {}
    cities = all.map { |robot| robot.city }.uniq
    cities.each do |city|
      by_city[city.upcase] = 0
      all.each do |robot|
        by_city[city.upcase] += 1 if robot.city.upcase == city.upcase
      end
    end
    by_city
  end

  def self.robots_by_state
    by_state = {}
    states = all.map { |robot| robot.state }.uniq
    states.each do |state|
      by_state[state.upcase] = 0
      all.each do |robot|
        by_state[state.upcase] += 1 if robot.state.upcase == state.upcase
      end
    end
    by_state
  end
end
