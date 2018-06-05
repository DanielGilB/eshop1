require "#{File.dirname(__FILE__)}/../test_helper"

class BrowsingAndSearchingTest < ActionController::IntegrationTest
  fixtures :producers, :authors, :discs, :authors_discs


def test_browsing_the_site
  jill = enter_site(:jill)
  jill.browse_index
  jill.go_to_second_page
  jill.get_book_details_for "Pride and Prejudice"
  jill.searches_for_tolstoy
  jill.views_latest_books
end

def test_getting_details
  jill = enter_site(:jill)
  jill.get_disc_details_for "Pride and Prejudice"
end

private


module BrowsingTestDSL
  include ERB::Util
  attr_writer :name
  def browse_index
    get "/catalog"
    assert_response :success
    assert_template "catalog/index"
    assert_tag :tag => "dl", :attributes =>
                  { :id => "discs" },
                :children =>
                  { :count => 10, :only =>
                   {:tag => "dt"}}
    assert_tag :tag => "dt", :content => "The Idiot"
    check_disc_links

  end

  def go_to_second_page
    get "/catalog?page=2"
    assert_response :success
    assert_template "catalog/index"
    assert_equal  Disc.find_by_title("Pro Rails E-Commerce"),
                  assigns(:discs).last
    check_disc_links
  end

  def get_disc_details_for(title)
    @disc = Disc.find_by_title(title)

    get "/catalog/show/#{@disc.id}"
    assert_response :success
    assert_template "catalog/show"

    assert_tag  :tag => "h1",
                :content => @disc.title

    assert_tag  :tag => "h2",
                :content => "by #{@disc.authors.map{|a| a.name}}"
  end

  def searches_for_tolstoy
    leo = Author.find_by_first_name_and_last_name("Leo", "Tolstoy")

    get "/catalog/search?q=#{url_encode("Leo Tolstoy")}"
    assert_response :success
    assert_template "catalog/search"
    assert_tag      :tag => "dl", :attributes =>
                      { :id => "discs" },
                    :children =>
                      { :count => leo.discs.size, :only =>
                        {:tag => "dt"}}
    leo.discs.each do |disc|
      assert_tag :tag => "dt", :content => disc.title
    end
  end

  def check_disc_links
    for disc in assigns(:discs)
      assert_tag    :tag => "a", :attributes =>
                      { :href => "/catalog/show/#{disc.id}"}
    end
  end
end

  def enter_site(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end