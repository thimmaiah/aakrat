require "test_helper"

class SiteVisitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site_visit = site_visits(:one)
  end

  test "should get index" do
    get site_visits_url
    assert_response :success
  end

  test "should get new" do
    get new_site_visit_url
    assert_response :success
  end

  test "should create site_visit" do
    assert_difference("SiteVisit.count") do
      post site_visits_url, params: { site_visit: { assigned_to_id: @site_visit.assigned_to_id, company_id: @site_visit.company_id, completed: @site_visit.completed, conducted_on: @site_visit.conducted_on, cost_cents: @site_visit.cost_cents, phase_id: @site_visit.phase_id, project_id: @site_visit.project_id, scheduled_on: @site_visit.scheduled_on } }
    end

    assert_redirected_to site_visit_url(SiteVisit.last)
  end

  test "should show site_visit" do
    get site_visit_url(@site_visit)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_visit_url(@site_visit)
    assert_response :success
  end

  test "should update site_visit" do
    patch site_visit_url(@site_visit), params: { site_visit: { assigned_to_id: @site_visit.assigned_to_id, company_id: @site_visit.company_id, completed: @site_visit.completed, conducted_on: @site_visit.conducted_on, cost_cents: @site_visit.cost_cents, phase_id: @site_visit.phase_id, project_id: @site_visit.project_id, scheduled_on: @site_visit.scheduled_on } }
    assert_redirected_to site_visit_url(@site_visit)
  end

  test "should destroy site_visit" do
    assert_difference("SiteVisit.count", -1) do
      delete site_visit_url(@site_visit)
    end

    assert_redirected_to site_visits_url
  end
end
