require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test "test_name" do
    artist = Artist.create(:first_name => 'Joel', :last_name => 'Spolsky')
    assert_equal 'Joel Spolsky', artist.name
  end
end
