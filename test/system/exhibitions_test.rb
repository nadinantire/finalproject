require "application_system_test_case"

class ExhibitionsTest < ApplicationSystemTestCase
  setup do
    @exhibition = exhibitions(:one)
  end

  test "visiting the index" do
    visit exhibitions_url
    assert_selector "h1", text: "Exhibitions"
  end

  test "creating a Exhibition" do
    visit exhibitions_url
    click_on "New Exhibition"

    fill_in "Date", with: @exhibition.date
    fill_in "End time", with: @exhibition.end_time
    fill_in "Image", with: @exhibition.image
    fill_in "Name", with: @exhibition.name
    fill_in "Start time", with: @exhibition.start_time
    click_on "Create Exhibition"

    assert_text "Exhibition was successfully created"
    click_on "Back"
  end

  test "updating a Exhibition" do
    visit exhibitions_url
    click_on "Edit", match: :first

    fill_in "Date", with: @exhibition.date
    fill_in "End time", with: @exhibition.end_time
    fill_in "Image", with: @exhibition.image
    fill_in "Name", with: @exhibition.name
    fill_in "Start time", with: @exhibition.start_time
    click_on "Update Exhibition"

    assert_text "Exhibition was successfully updated"
    click_on "Back"
  end

  test "destroying a Exhibition" do
    visit exhibitions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exhibition was successfully destroyed"
  end
end
