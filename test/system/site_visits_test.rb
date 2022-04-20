require "application_system_test_case"

class SiteVisitsTest < ApplicationSystemTestCase
  setup do
    @site_visit = site_visits(:one)
  end

  test "visiting the index" do
    visit site_visits_url
    assert_selector "h1", text: "Site visits"
  end

  test "should create site visit" do
    visit site_visits_url
    click_on "New site visit"

    fill_in "Assigned to", with: @site_visit.assigned_to_id
    fill_in "Company", with: @site_visit.company_id
    check "Completed" if @site_visit.completed
    fill_in "Conducted on", with: @site_visit.conducted_on
    fill_in "Cost cents", with: @site_visit.cost_cents
    fill_in "Phase", with: @site_visit.phase_id
    fill_in "Project", with: @site_visit.project_id
    fill_in "Scheduled on", with: @site_visit.scheduled_on
    click_on "Create Site visit"

    assert_text "Site visit was successfully created"
    click_on "Back"
  end

  test "should update Site visit" do
    visit site_visit_url(@site_visit)
    click_on "Edit this site visit", match: :first

    fill_in "Assigned to", with: @site_visit.assigned_to_id
    fill_in "Company", with: @site_visit.company_id
    check "Completed" if @site_visit.completed
    fill_in "Conducted on", with: @site_visit.conducted_on
    fill_in "Cost cents", with: @site_visit.cost_cents
    fill_in "Phase", with: @site_visit.phase_id
    fill_in "Project", with: @site_visit.project_id
    fill_in "Scheduled on", with: @site_visit.scheduled_on
    click_on "Update Site visit"

    assert_text "Site visit was successfully updated"
    click_on "Back"
  end

  test "should destroy Site visit" do
    visit site_visit_url(@site_visit)
    click_on "Destroy this site visit", match: :first

    assert_text "Site visit was successfully destroyed"
  end
end
