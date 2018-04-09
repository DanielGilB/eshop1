require 'test_helper'

class Admin::ArtistControllerTest < ActionController::TestCase
 fixtures :artists

  test "new" do
    get :new
    assert_template 'admin/artist/new'
    assert_select 'div#content' do
      assert_select 'h1', 'Create new author'
      assert_select "form[action=\"/admin/artist/create\"]"
    end
    # assert_tag 'h1', :content => 'Create new author'
    # assert_tag 'form', :attributes => { :action => '/admin/author/create' }
  end

  test "create" do
    get :new    
    assert_template 'admin/artist/new'
    assert_difference(Author, :count) do
      post :create, :author => {:first_name => 'Joel', :last_name => 'Spolsky'}
      assert_response :redirect
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'Author Joel Spolsky was succesfully created.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Artist, :count) do
      post :create, :author => {:first_name => 'Joel'}
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
    # assert_tag :tag => 'input', :attributes => { :name => 'author[last_name]', :value => 'Spolsky' }
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
      assert_equal flash[:notice], 'Succesfully deleted author Joel Spolsky.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_select 'div#notice', 'Succesfully deleted author Joel Spolsky.'
      # assert_tag :tag => 'div', :attributes => {:id => 'notice'},
      #   :content => 'Succesfully deleted author Joel Spolsky.'
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
    # assert_tag "h1", :content => Author.find(1).name
  end

  test "index" do
    get :index
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', Artist.count + 1
    end
    # assert_tag :tag => 'table', :children => { :count => Author.count + 1, :only => {:tag => 'tr'} }
    Artist.find_each do |a|
      assert_select 'td', a.name
      # assert_tag :tag => 'td', :content => a.name
    end
  end
end