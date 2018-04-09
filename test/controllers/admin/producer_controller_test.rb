require 'test_helper'

class Admin::ProducerControllerTest < ActionController::TestCase
  fixtures :producers

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    num_producers = Producer.count
    post :create, :producer => { :name => 'The Monopoly Publishing Company' }
    assert_response :redirect
    assert_redirected_to :action => 'index'
    assert_equal num_producers + 1, Producer.count
  end

  test "edit" do
    get :edit, :id => 1
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'producer[name]'
      assert_select '[value=?]', 'Apress'
    end
  end

  test "update" do
    post :update, :id => 1, :producer => { :name => 'Apress.com' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Apress.com', Producer.find(1).name
  end

  test "destroy" do
    assert_difference(Producer, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'La Productora Apress fue eliminada con éxito.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_select 'div#notice', 'La Productora Apress fue eliminada con éxito.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_response :success
    assert_template 'admin/producer/show'
    assert_not_nil assigns(:producer)
    assert assigns(:producer).valid?
    assert_select 'div#content' do
      assert_select 'h1', Producer.find(1).name
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', Producer.count + 1
    end
    Producer.find_each do |a|
      assert_select 'td', a.name
    end
  end
end
