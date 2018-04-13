require 'test_helper'

class Admin::ArtistControllerTest < ActionController::TestCase
 fixtures :artists

  test "new" do
    get :new
    assert_template 'admin/artist/new'
    assert_select 'div#content' do
      assert_select 'h1', 'Create new artist'
      assert_select "form[action=\"/admin/artist/create\"]"
    end
  end

  test "create" do
    get :new    
    assert_template 'admin/artist/new'
    assert_difference(Artist, :count) do
      post :create, :artist => {:first_name => 'Joel', :last_name => 'Spolsky'}
      assert_response :redirect
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'Artista Joel Spolsky insertado con éxito.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Artist, :count) do
      post :create, :artist => {:first_name => 'J'}
      assert_response :success
      assert_template 'admin/artist/new'
      assert_select "div[class=\"field_with_errors\"]"
    end
  end

  test "edit" do
    get :edit, :id => 1
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'artist[first_name]'
      assert_select '[value=?]', 'Joel'
    end
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'artist[last_name]'
      assert_select '[value=?]', 'Spolsky'
    end
  end

  test "update" do
    post :update, :id => 1, :artist => { :first_name => 'Joseph', :last_name => 'Spolsky' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Joseph', Artist.find(1).first_name
  end

  test "test_destroy" do
    assert_difference(Artist, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'Artista Joel Spolsky eliminado con éxito.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_select 'div#notice', 'Artista Joel Spolsky eliminado con éxito.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/artist/show'
    assert_equal 'Joel', assigns(:artist).first_name
    assert_equal 'Spolsky', assigns(:artist).last_name
    assert_select 'div#content' do
      assert_select 'h1', Artist.find(1).name
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', Artist.count + 1
    end
    Artist.find_each do |a|
      assert_select 'td', a.name
    end
  end
end