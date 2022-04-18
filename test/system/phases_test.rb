require "application_system_test_case"

class PhasesTest < ApplicationSystemTestCase
  setup do
    @phase = phases(:one)
  end

  test "visiting the index" do
    visit phases_url
    assert_selector "h1", text: "Phases"
  end

  test "should create phase" do
    visit phases_url
    click_on "New phase"

    fill_in "Assigned to", with: @phase.assigned_to_id
    check "Completed" if @phase.completed
    fill_in "End date", with: @phase.end_date
    fill_in "Name", with: @phase.name
    fill_in "Payment status", with: @phase.payment_status
    fill_in "Percentage complete", with: @phase.percentage_complete
    fill_in "Project", with: @phase.project_id
    fill_in "Start date", with: @phase.start_date
    fill_in "Status", with: @phase.status
    check "Visible to client" if @phase.visible_to_client
    click_on "Create Phase"

    assert_text "Phase was successfully created"
    click_on "Back"
  end

  test "should update Phase" do
    visit phase_url(@phase)
    click_on "Edit this phase", match: :first

    fill_in "Assigned to", with: @phase.assigned_to_id
    check "Completed" if @phase.completed
    fill_in "End date", with: @phase.end_date
    fill_in "Name", with: @phase.name
    fill_in "Payment status", with: @phase.payment_status
    fill_in "Percentage complete", with: @phase.percentage_complete
    fill_in "Project", with: @phase.project_id
    fill_in "Start date", with: @phase.start_date
    fill_in "Status", with: @phase.status
    check "Visible to client" if @phase.visible_to_client
    click_on "Update Phase"

    assert_text "Phase was successfully updated"
    click_on "Back"
  end

  test "should destroy Phase" do
    visit phase_url(@phase)
    click_on "Destroy this phase", match: :first

    assert_text "Phase was successfully destroyed"
  end
end
