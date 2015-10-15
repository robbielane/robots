require_relative '../test_helper'

class RobotsTest < Minitest::Test
  def generate_robots(num)
    num.times do |i|
      Robots.create({:name => "robbie#{i}",
                     :city => "Denver",
                     :state => "CO",
                     :avatar => "https://robohash.org/robbie#{i}.png",
                     :birthdate => "07/24/1987",
                     :date_hired => "10/15/2015",
                     :department => "IT",
                     })
    end
  end

  def test_it_can_create_a_robot
    generate_robots(1)
    robot = Robots.find(1)

    assert_equal "robbie0", robot.name
    assert_equal "https://robohash.org/robbie0.png", robot.avatar
  end

  def test_all_returns_all_robots
    generate_robots(4)
    all_robots = Robots.all

    assert_equal ["robbie0", "robbie1", "robbie2", "robbie3"],
        all_robots.map { |robot| robot.name }
  end

  def test_find_returns_correct_robot
    generate_robots(3)

    assert_equal "robbie1", Robots.find(2).name
    assert_equal "https://robohash.org/robbie1.png", Robots.find(2).avatar
  end

  def test_update_modifies_existing_robot
    generate_robots(2)
    Robots.edit(2, {:name => "peter",
                    :city => "Juneau",
                    :state => "AK",
                    :birthdate => "07/24/1987",
                    :date_hired => "10/15/2015",
                    :department => "IT"
                    })
    robot = Robots.find(2)

    assert_equal "peter", robot.name
    assert_equal "Juneau", robot.city
    assert_equal "AK", robot.state
  end

  def test_delete_removes_robot_from_database
    generate_robots(2)

    assert_equal ["robbie0", "robbie1"], Robots.all.map { |robot| robot.name }

    Robots.delete(1)
    Robots.delete(2)

    assert_equal [], Robots.all
  end
end
