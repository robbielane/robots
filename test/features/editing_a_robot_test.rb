require_relative '../test_helper'

class EditRobotTest < FeatureTest
  def test_user_can_edit_an_existing_robot
    generate_robots(1)

    visit "/robots/#{Robots.all.last.id}/edit"

    assert_equal "/robots/#{Robots.all.last.id}/edit", current_path

    fill_in('robot[name]', :with => "George")
    fill_in('robot[city]', :with => "Madison")
    fill_in('robot[state]', :with => "WI")
    fill_in('robot[birthdate]', :with => "07/24/1987")
    fill_in('robot[date_hired]', :with => "10/15/2015")
    fill_in('robot[department]', :with => "Finance")
    click_button('Submit')

    assert_equal "/robots/#{Robots.all.last.id}", current_path

    within('#robot-info') do
      assert page.has_content?('George')
      assert page.has_content?('Madison, WI')
      assert page.has_content?('07/24/1987')
      assert page.has_content?('10/15/2015')
      assert page.has_content?('Finance')
    end
  end
end
