require "test_helper"

class PhasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phase = phases(:one)
  end

  test "should get index" do
    get phases_url
    assert_response :success
  end

  test "should get new" do
    get new_phase_url
    assert_response :success
  end

  test "should create phase" do
    assert_difference("Phase.count") do
      post phases_url, params: { phase: { assigned_to_id: @phase.assigned_to_id, completed: @phase.completed, end_date: @phase.end_date, name: @phase.name, payment_status: @phase.payment_status, percentage_complete: @phase.percentage_complete, project_id: @phase.project_id, start_date: @phase.start_date, status: @phase.status, visible_to_client: @phase.visible_to_client } }
    end

    assert_redirected_to phase_url(Phase.last)
  end

  test "should show phase" do
    get phase_url(@phase)
    assert_response :success
  end

  test "should get edit" do
    get edit_phase_url(@phase)
    assert_response :success
  end

  test "should update phase" do
    patch phase_url(@phase), params: { phase: { assigned_to_id: @phase.assigned_to_id, completed: @phase.completed, end_date: @phase.end_date, name: @phase.name, payment_status: @phase.payment_status, percentage_complete: @phase.percentage_complete, project_id: @phase.project_id, start_date: @phase.start_date, status: @phase.status, visible_to_client: @phase.visible_to_client } }
    assert_redirected_to phase_url(@phase)
  end

  test "should destroy phase" do
    assert_difference("Phase.count", -1) do
      delete phase_url(@phase)
    end

    assert_redirected_to phases_url
  end
end
