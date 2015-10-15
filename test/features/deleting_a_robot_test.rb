require_relative '../test_helper'

class EditingRobotTest < FeatureTest
  def test_user_can_delete_a_Robot
    generate_robots(1)

    visit '/robots'
    within('table') do
      assert has_content?('robbie0')
    end
    click_button('delete')

    assert_equal '/robots', current_path
    within('table') do
      refute has_content?('robbie0')
    end
  end
end
