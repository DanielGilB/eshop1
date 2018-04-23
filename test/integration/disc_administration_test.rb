require 'test_helper'

class DiscAdministrationTest < ActionDispatch::IntegrationTest

  test "disc_aministration" do
    producer = Producer.create(:name => 'Discs of Ruby')
    artist = Artist.create(:first_name => 'John', :last_name => 'Anderson')
    george = new_session_as(:george)

    new_disc_ruby = george.add_disc :disc => {
      :title => 'A new Disc of Ruby',
      :producer_id => producer.id,
      :artist_ids => [artist.id],
      :produced_at => Time.now,
      :serial_number => '123',
      :blurb => 'A new Disc of Ruby',
      :price => 45.5
    }

    george.list_discs
    george.show_disc new_disc_ruby

    george.edit_disc new_disc_ruby, :disc => {
      :title => 'A very new Disc of Ruby',
      :producer_id => producer.id,
      :artist_ids => [artist.id],
      :produced_at => Time.now,
      :serial_number => '124',
      :blurb => 'A very new Disc of Ruby',
      :price => 50
    }

    bob = new_session_as(:bob)
    bob.delete_disc new_disc_ruby
  end

  private

  module DiscTestDSL
    attr_writer :name

    def add_disc(parameters)
      artist = Artist.first
      producer = Producer.first
      get '/admin/disc/new'
      assert_response :success
      assert_template 'admin/disc/new'
      assert_select 'select#disc_producer_id' do
        assert_select "option[value=\"#{producer.id}\"]", producer.name
      end
      assert_select "select[name=\"disc[artist_ids][]\"]" do
        assert_select "option[value=\"#{artist.id}\"]", artist.name
      end
      post '/admin/disc/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/disc/index'
      page = Disc.all.count / 5 + 1
      get "/admin/disc/index/?page=#{page}"
      assert_select 'td', parameters[:disc][:title]
      disc = Disc.find_by_title(parameters[:disc][:title])
      return disc;
    end

    def edit_disc(disc, parameters)
      get "/admin/disc/edit?id=#{disc.id}"
      assert_response :success
      assert_template 'admin/disc/edit'
      post "/admin/disc/update?id=#{disc.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/disc/show'
    end

    def delete_disc(disc)
      post "/admin/disc/destroy?id=#{disc.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/disc/index'
    end

    def show_disc(disc)
      get "/admin/disc/show?id=#{disc.id}"
      assert_response :success
      assert_template 'admin/disc/show'
    end

    def list_discs
      get '/admin/disc/index'
      assert_response :success
      assert_template 'admin/disc/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(DiscTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
