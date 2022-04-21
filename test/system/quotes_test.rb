require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:one)
  end

  test "visiting the index" do
    visit quotes_url
    assert_selector "h1", text: "Quotes"
  end

  test "should create quote" do
    visit quotes_url
    click_on "New quote"

    fill_in "Client", with: @quote.client_id
    fill_in "Company", with: @quote.company_id
    fill_in "Pattern", with: @quote.pattern
    fill_in "Project type", with: @quote.project_type
    fill_in "Scale", with: @quote.scale
    fill_in "Services", with: @quote.services
    fill_in "Style", with: @quote.style
    fill_in "User", with: @quote.user_id
    click_on "Create Quote"

    assert_text "Quote was successfully created"
    click_on "Back"
  end

  test "should update Quote" do
    visit quote_url(@quote)
    click_on "Edit this quote", match: :first

    fill_in "Client", with: @quote.client_id
    fill_in "Company", with: @quote.company_id
    fill_in "Pattern", with: @quote.pattern
    fill_in "Project type", with: @quote.project_type
    fill_in "Scale", with: @quote.scale
    fill_in "Services", with: @quote.services
    fill_in "Style", with: @quote.style
    fill_in "User", with: @quote.user_id
    click_on "Update Quote"

    assert_text "Quote was successfully updated"
    click_on "Back"
  end

  test "should destroy Quote" do
    visit quote_url(@quote)
    click_on "Destroy this quote", match: :first

    assert_text "Quote was successfully destroyed"
  end
end
