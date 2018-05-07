require 'test_helper'

class BrowsingAndSearchingTest < ActionDispatch::IntegrationTest
  fixtures :producers, :artists, :discs, :artists_discs

  test "browse" do
    jill = new_session_as :jill
    jill.index
    jill.second_page
    jill.disc_details 'Christian Hellsten'
    jill.latest_discs
  end

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def index
      get '/catalog/index'
      assert_response :success
      assert_select 'dl#discs' do
        assert_select 'dt', :count => 5
      end
      assert_select 'dt' do
        assert_select 'a', 'The Idiot'
      end

      check_disc_links
    end

    def second_page
      get '/catalog/index?page=2'
      assert_response :success
      assert_template 'catalog/index'
      assert_equal Disc.find_by_title('Pro Rails E-Commerce'),
                   assigns(:discs).last
      check_disc_links
    end

    def disc_details(title)
      @disc = Disc.where(:title => title).first
      get "/catalog/show/#{@disc.id}"
      assert_response :success
      assert_template 'catalog/show'
      assert_select 'div#content' do
        assert_select 'h1', @disc.title
        assert_select 'h2', "#{@disc.artists.map{|a| a.name}.join(", ")}"
      end

    end

    def latest_discs
      get '/catalog/latest'
      assert_response :success
      assert_template 'catalog/latest'
      assert_select 'dl#discs' do
        assert_select 'dt', :count => 5
      end

      @discs = Disc.latest(5)
      @discs.each do |a|
        assert_select 'dt' do
          assert_select 'a', a.title
        end

      end
    end

    def check_disc_links
      for disc in assigns :discs
        assert_select 'a' do
          assert_select '[href=?]', "/catalog/show/#{disc.id}"
        end

      end
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
