require 'test_helper'

class CortegeContributionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cortege_contribution = cortege_contributions(:one)
  end

  test "should get index" do
    get cortege_contributions_url
    assert_response :success
  end

  test "should get new" do
    get new_cortege_contribution_url
    assert_response :success
  end

  test "should create cortege_contribution" do
    assert_difference('CortegeContribution.count') do
      post cortege_contributions_url, params: { cortege_contribution: {  } }
    end

    assert_redirected_to cortege_contribution_url(CortegeContribution.last)
  end

  test "should show cortege_contribution" do
    get cortege_contribution_url(@cortege_contribution)
    assert_response :success
  end

  test "should get edit" do
    get edit_cortege_contribution_url(@cortege_contribution)
    assert_response :success
  end

  test "should update cortege_contribution" do
    patch cortege_contribution_url(@cortege_contribution), params: { cortege_contribution: {  } }
    assert_redirected_to cortege_contribution_url(@cortege_contribution)
  end

  test "should destroy cortege_contribution" do
    assert_difference('CortegeContribution.count', -1) do
      delete cortege_contribution_url(@cortege_contribution)
    end

    assert_redirected_to cortege_contributions_url
  end
end
