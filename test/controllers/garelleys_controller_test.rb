require 'test_helper'

class GarelleysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @garelley = garelleys(:one)
  end

  test "should get index" do
    get garelleys_url
    assert_response :success
  end

  test "should get new" do
    get new_garelley_url
    assert_response :success
  end

  test "should create garelley" do
    assert_difference('Garelley.count') do
      post garelleys_url, params: { garelley: { image: @garelley.image, name: @garelley.name } }
    end

    assert_redirected_to garelley_url(Garelley.last)
  end

  test "should show garelley" do
    get garelley_url(@garelley)
    assert_response :success
  end

  test "should get edit" do
    get edit_garelley_url(@garelley)
    assert_response :success
  end

  test "should update garelley" do
    patch garelley_url(@garelley), params: { garelley: { image: @garelley.image, name: @garelley.name } }
    assert_redirected_to garelley_url(@garelley)
  end

  test "should destroy garelley" do
    assert_difference('Garelley.count', -1) do
      delete garelley_url(@garelley)
    end

    assert_redirected_to garelleys_url
  end
end
