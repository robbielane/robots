class Robots
  def self.database
    if ENV['RACK_ENV'] == 'test'
      @database ||= Sequel.sqlite("db/robots_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robots_enviroment.sqlite3")
    end
  end

  def self.dataset
    database.from(:robots)
  end

  def self.create(data)
    dataset.insert(data)
  end

  def self.all
    dataset.to_a.map { |data| Robot.new(data) }
  end

  def self.find(id)
    Robot.new(dataset.where(:id => id).to_a.first)
  end

  def self.edit(id, data)
    dataset.where(:id => id).update(data)
  end

  def self.delete(id)
    dataset.where(:id => id).delete
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
    departments = all.map { |robot| robot.department }.uniq.sort
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
    cities = all.map { |robot| robot.city }.uniq.sort
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
    states = all.map { |robot| robot.state }.uniq.sort
    states.each do |state|
      by_state[state.upcase] = 0
      all.each do |robot|
        by_state[state.upcase] += 1 if robot.state.upcase == state.upcase
      end
    end
    by_state
  end

  def self.delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end
end
