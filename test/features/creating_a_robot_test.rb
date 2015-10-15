require_relative '../test_helper'

class CreateRobotTest < FeatureTest
  def test_user_can_create_a_robot
    visit '/robots/new'

    assert_equal '/robots/new', current_path

    fill_in('robot[name]', :with => "Robbie")
    fill_in('robot[city]', :with => "Denver")
    fill_in('robot[state]', :with => "CO")
    fill_in('robot[birthdate]', :with => "07/24/1987")
    fill_in('robot[date_hired]', :with => "10/15/2015")
    fill_in('robot[department]', :with => "Robot Resources")
    click_button('Submit')

    assert_equal '/robots', current_path

    within('table') do
      assert page.has_content?("Robbie")
      assert page.has_content?("Denver")
      assert page.has_content?("CO")
      assert page.has_content?("07/24/1987")
      assert page.has_content?("10/15/2015")
      assert page.has_content?("Robot Resources")
    end
  end
end
