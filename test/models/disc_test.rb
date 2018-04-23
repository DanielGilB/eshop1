require 'test_helper'

class DiscTest < ActiveSupport::TestCase
 fixtures :artists, :producers, :discs, :artists_discs

  test "failing_create" do
    disc = Disc.new
    assert_equal false, disc.save
    assert_equal 8, disc.errors.count
    assert disc.errors[:title]
    assert disc.errors[:producer]
    assert disc.errors[:artists]
    assert disc.errors[:produced_at]
    assert disc.errors[:isbn]
    assert disc.errors[:blurb]
    assert disc.errors[:page_count]
    assert disc.errors[:price]
  end

  test "create" do
    disc = Disc.new(
      :title => 'Ruby on Rails',
      :artists => Artist.all,
      :producer_id => Producer.find(1).id,
      :produced_at => Time.now,
      :isbn => '123-123-123-1',
      :blurb => 'A great disc',
      :page_count => 375,
      :price => 45.5
    )
  assert disc.save
  end

  test "has_many_and_belongs_to_mapping" do
    apress = Producer.find_by_name("Apress");
    count = apress.discs.count
    disc = Disc.new(
      :title => 'Pro Rails E-Commerce 8th Edition',
      :artists => [Artist.find_by_first_name_and_last_name('Joel', 'Spolsky'),
                   Artist.find_by_first_name_and_last_name('Jeremy', 'Keith')],
      :producer_id => apress.id,
      :produced_at => Time.now,
      :isbn => '123-123-123-x',
      :blurb => 'E-Commerce on Rails',
      :page_count => 400,
      :price => 55.5
    )
    apress.discs << disc
    apress.reload
    disc.reload
    assert_equal count + 1, apress.discs.count
    assert_equal 'Apress', disc.producer.name
  end

  test "has_many_and_belongs_to_many_artists_mapping" do
    disc = Disc.new(
      :title => 'Pro Rails E-Commerce 8th Edition',
      :artists => [Artist.find_by_first_name_and_last_name('Joel', 'Spolsky'),
                   Artist.find_by_first_name_and_last_name('Jeremy', 'Keith')],
      :producer_id => Producer.find_by_name("Apress").id,
      :produced_at => Time.now,
      :isbn => '123-123-123-x',
      :blurb => 'E-Commerce on Rails',
      :page_count => 400,
      :price => 55.5
    )
    assert disc.save
    disc.reload
    assert_equal 2, disc.artists.count
    assert_equal 2, Artist.find_by_first_name_and_last_name('Joel', 'Spolsky').discs.count
  end
end
