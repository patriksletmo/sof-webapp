require 'test_helper'

class CortegeLineupsManagementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cortege_lineups_management = cortege_lineups_managements(:one)
  end

  test "should get index" do
    get cortege_lineups_managements_url
    assert_response :success
  end

  test "should get new" do
    get new_cortege_lineups_management_url
    assert_response :success
  end

  test "should create cortege_lineups_management" do
    assert_difference('CortegeLineupsManagement.count') do
      post cortege_lineups_managements_url, params: { cortege_lineups_management: {  } }
    end

    assert_redirected_to cortege_lineups_management_url(CortegeLineupsManagement.last)
  end

  test "should show cortege_lineups_management" do
    get cortege_lineups_management_url(@cortege_lineups_management)
    assert_response :success
  end

  test "should get edit" do
    get edit_cortege_lineups_management_url(@cortege_lineups_management)
    assert_response :success
  end

  test "should update cortege_lineups_management" do
    patch cortege_lineups_management_url(@cortege_lineups_management), params: { cortege_lineups_management: {  } }
    assert_redirected_to cortege_lineups_management_url(@cortege_lineups_management)
  end

  test "should destroy cortege_lineups_management" do
    assert_difference('CortegeLineupsManagement.count', -1) do
      delete cortege_lineups_management_url(@cortege_lineups_management)
    end

    assert_redirected_to cortege_lineups_managements_url
  end
end
