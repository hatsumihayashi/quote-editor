require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @quote = Quote.ordered.first
  end

  test "Showing a quote" do
    visit quotes_path
    click_link @quote.name

    assert_selector "h1", text: @quote.name
  end


  test "Creating a new quote" do
    visit quotes_path
    assert_selector "h1", text: "見積り一覧"

    click_on "見積りを追加"
    fill_in "見積りのタイトル", with: "Capybaraで見積り"

    assert_selector "h1", text: "見積り一覧"
    click_on "追加する"

    assert_selector "h1", text: "見積り一覧"
    assert_text "Capybaraで見積り"
  end


  test "Updating a quote" do
    visit quotes_path
    assert_selector "h1", text: "見積り一覧"

    click_on "更新", match: :first
    fill_in "見積りのタイトル", with: "見積りをあたらしいNameに更新"

    assert_selector "h1", text: "見積り一覧"
    click_on "更新する"

    assert_selector "h1", text: "見積り一覧"
    assert_text "見積りをあたらしいNameに更新"
  end

  test "Destroying a quote" do
    visit quotes_path
    assert_text @quote.name

    click_on "削除", match: :first
    assert_no_text @quote.name
  end
end
