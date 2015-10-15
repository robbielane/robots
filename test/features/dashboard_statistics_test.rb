require_relative '../test_helper'

class DashboardStatisticsTest < FeatureTest
  def test_dashboard_displays_pertinent_information
    generate_robots(10)

    visit '/'
    within('#age') do
      assert has_content?('63.0')
    end

    within('#hiring-by-year') do
      assert has_content?('2005')
      assert has_content?('2015')
      assert has_content?('2025')
      assert has_content?('2035')
      assert has_content?('2045')
      assert has_content?('2055')
      assert has_content?('2065')
      assert has_content?('2075')
      assert has_content?('2085')
      assert has_content?('2095')
      refute has_content?('1999')
      refute has_content?('1800')
    end

    within('#by-department') do
      assert has_content?('IT0')
      assert has_content?('IT1')
      assert has_content?('IT2')
      assert has_content?('IT3')
      assert has_content?('IT4')
      assert has_content?('IT5')
      assert has_content?('IT6')
      assert has_content?('IT7')
      assert has_content?('IT8')
      assert has_content?('IT9')
      refute has_content?('Human Resources')
    end

    within('#by-city') do
      assert has_content?('DENVER0')
      assert has_content?('DENVER1')
      assert has_content?('DENVER2')
      assert has_content?('DENVER3')
      assert has_content?('DENVER4')
      assert has_content?('DENVER5')
      assert has_content?('DENVER6')
      assert has_content?('DENVER7')
      assert has_content?('DENVER8')
      assert has_content?('DENVER9')
      refute has_content?('ASPEN')
    end

    within('#by-state') do
      assert has_content?('CO')
      refute has_content?('AK')
    end
  end
end
