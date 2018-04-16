require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test "test_name" do
    artist = Artist.create(:first_name => 'John', :last_name => 'Newton')
    assert_equal 'John Newton', artist.name
  end
end
