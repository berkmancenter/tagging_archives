require 'test_helper'

class TaggedItemsControllerTest < ActionController::TestCase
  setup do
    @tagged_item = tagged_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tagged_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tagged_item" do
    assert_difference('TaggedItem.count') do
      post :create, tagged_item: @tagged_item.attributes
    end

    assert_redirected_to tagged_item_path(assigns(:tagged_item))
  end

  test "should show tagged_item" do
    get :show, id: @tagged_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tagged_item
    assert_response :success
  end

  test "should update tagged_item" do
    put :update, id: @tagged_item, tagged_item: @tagged_item.attributes
    assert_redirected_to tagged_item_path(assigns(:tagged_item))
  end

  test "should destroy tagged_item" do
    assert_difference('TaggedItem.count', -1) do
      delete :destroy, id: @tagged_item
    end

    assert_redirected_to tagged_items_path
  end
end
