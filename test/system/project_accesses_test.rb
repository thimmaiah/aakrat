require "application_system_test_case"

class ProjectAccessesTest < ApplicationSystemTestCase
  setup do
    @project_access = project_accesses(:one)
  end

  test "visiting the index" do
    visit project_accesses_url
    assert_selector "h1", text: "Project accesses"
  end

  test "should create project access" do
    visit project_accesses_url
    click_on "New project access"

    fill_in "Company", with: @project_access.company_id
    fill_in "Project", with: @project_access.project_id
    fill_in "Role name", with: @project_access.role_name
    fill_in "User", with: @project_access.user_id
    click_on "Create Project access"

    assert_text "Project access was successfully created"
    click_on "Back"
  end

  test "should update Project access" do
    visit project_access_url(@project_access)
    click_on "Edit this project access", match: :first

    fill_in "Company", with: @project_access.company_id
    fill_in "Project", with: @project_access.project_id
    fill_in "Role name", with: @project_access.role_name
    fill_in "User", with: @project_access.user_id
    click_on "Update Project access"

    assert_text "Project access was successfully updated"
    click_on "Back"
  end

  test "should destroy Project access" do
    visit project_access_url(@project_access)
    click_on "Destroy this project access", match: :first

    assert_text "Project access was successfully destroyed"
  end
end
