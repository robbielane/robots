require_relative "../test_helper"

class RobotsIndexTest < FeatureTest
  def test_index_is_accessable_from_root_page
    visit '/'
    click_link('Robot Directory')

    assert_equal '/robots', current_path
  end

  def test_index_displays_table_of_all_robots_and_data
    generate_robots(5)

    visit '/robots'

    within('table') do
      assert has_content?('robbie0')
      assert has_content?('robbie1')
      assert has_content?('robbie2')
      assert has_content?('robbie3')
      assert has_content?('robbie4')
      assert has_content?('Denver0')
      assert has_content?('Denver1')
      assert has_content?('Denver2')
      assert has_content?('Denver3')
      assert has_content?('Denver4')
      assert has_content?('1907')
      assert has_content?('1917')
      assert has_content?('1927')
      assert has_content?('1937')
      assert has_content?('1947')
      assert has_content?('2005')
      assert has_content?('2015')
      assert has_content?('2025')
      assert has_content?('2035')
      assert has_content?('2045')
      assert has_content?('IT0')
      assert has_content?('IT1')
      assert has_content?('IT2')
      assert has_content?('IT3')
      assert has_content?('IT4')
    end
  end

  def test_dashboard_button_takes_user_to_dashbaord
    visit '/robots'
    click_link('Dashboard')

    assert_equal '/', current_path
  end

  def test_edit_button_takes_user_to_edit_page_for_correct_robot
    generate_robots(3)
    visit '/robots'

    within('#1') do
      click_link('Edit')
    end

    assert_equal "/robots/#{Robots.all[1].id}/edit", current_path
  end

  def test_delete_button_removes_correct_robot
    generate_robots(3)
    visit '/robots'

    within('#1') do
      click_link_or_button('Delete')
    end

    within('table') do
      assert has_content?('robbie0')
      assert has_content?('robbie2')
      refute has_content?('robbie1')
    end
  end
end
