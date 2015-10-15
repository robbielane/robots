require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_robot_stores_data_correctly
    robot = Robot.new({"id" => "1",
                       "name" => "Robbie",
                       "city" => "Denver",
                       "state" => "CO",
                       "avatar" => "https://robohash.org/robbie.png",
                       "birthdate" => "07/24/1987",
                       "date_hired" => "10/15/2015",
                       "department" => "IT",
                       })

    assert_equal "1", robot.id
    assert_equal "Robbie", robot.name
    assert_equal "Denver", robot.city
    assert_equal "CO", robot.state
    assert_equal "https://robohash.org/robbie.png", robot.avatar
    assert_equal "07/24/1987", robot.birthdate
    assert_equal "10/15/2015", robot.date_hired
    assert_equal "IT", robot.department
  end

  def test_it_calculates_a_robots_age
      robot = Robot.new({"birthdate" => "07/24/1987"})

      assert_equal 28, robot.age
  end
end
