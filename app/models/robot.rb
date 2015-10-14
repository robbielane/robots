class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :age,
              :department

  def initialize(data)
    @id         = data['id']
    @name       = data['name']
    @city       = data['city']
    @state      = data['state']
    @avatar     = data['avatar']
    @birthdate  = data['birthdate']
    @date_hired = data['date_hired']
    @department = data['department']
    @age        = calculate_age
  end

  def calculate_age
    temp = @birthdate.split('/')

    formatted_birthdate = [temp[1], temp[0], temp[2]].join('/')
    ((DateTime.now - Date.parse(formatted_birthdate)) / 365).to_i
  end

end
