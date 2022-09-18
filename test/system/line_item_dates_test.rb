require "application_system_test_case"

class LineItemDatesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)

    @quote          = quotes(:first)
    @line_item_date = line_item_dates(:today)

    visit quote_path(@quote)
  end

  test "Creating a new line item date" do
    assert_selector "h1", text: "First quote"

    click_on "日付を追加"
    assert_selector "h1", text: "First quote"
    fill_in "日付", with: Date.current + 1.day

    click_on "追加する"
    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test "Updating a line item date" do
    assert_selector "h1", text: "First quote"

    within id: dom_id(@line_item_date) do
      click_on "更新"
    end

    assert_selector "h1", text: "First quote"

    fill_in "日付", with: Date.current + 1.day
    click_on "更新する"

    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test "Destroying a line item date" do
    assert_text I18n.l(Date.current, format: :long)

    accept_confirm do
      within id: dom_id(@line_item_date) do
        click_on "削除"
      end
    end

    assert_no_text I18n.l(Date.current, format: :long)
  end
end
