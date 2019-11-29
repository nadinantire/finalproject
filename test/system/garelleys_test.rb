require "application_system_test_case"

class GarelleysTest < ApplicationSystemTestCase
  setup do
    @garelley = garelleys(:one)
  end

  test "visiting the index" do
    visit garelleys_url
    assert_selector "h1", text: "Garelleys"
  end

  test "creating a Garelley" do
    visit garelleys_url
    click_on "New Garelley"

    fill_in "Image", with: @garelley.image
    fill_in "Name", with: @garelley.name
    click_on "Create Garelley"

    assert_text "Garelley was successfully created"
    click_on "Back"
  end

  test "updating a Garelley" do
    visit garelleys_url
    click_on "Edit", match: :first

    fill_in "Image", with: @garelley.image
    fill_in "Name", with: @garelley.name
    click_on "Update Garelley"

    assert_text "Garelley was successfully updated"
    click_on "Back"
  end

  test "destroying a Garelley" do
    visit garelleys_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Garelley was successfully destroyed"
  end
end
