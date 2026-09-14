require 'rails_helper'

RSpec.describe "Adding a book", type: :feature do
  def fill_in_book(title: "The Pragmatic Programmer", author: "Andy Hunt", price: "39.99", published_date: Date.new(1999, 10, 20))
    visit new_book_path
    fill_in "Title", with: title
    fill_in "Author", with: author
    fill_in "Price", with: price
    select published_date.year.to_s, from: "book_published_date_1i"
    select Date::MONTHNAMES[published_date.month], from: "book_published_date_2i"
    select published_date.day.to_s, from: "book_published_date_3i"
    click_on "Create Book"
  end

  it "saves and displays the title" do
    fill_in_book
    expect(page).to have_content("Book was successfully created.")
    expect(page).to have_content("The Pragmatic Programmer")
  end

  it "rejects a blank title" do
    fill_in_book(title: "")
    expect(page).to have_content("Book could not be saved.")
    expect(page).to have_content("Title can't be blank")
  end

  it "saves and displays the author" do
    fill_in_book
    expect(page).to have_content("Andy Hunt")
  end

  it "saves and displays the price" do
    fill_in_book
    expect(page).to have_content("39.99")
  end

  it "saves and displays the published date" do
    fill_in_book
    expect(page).to have_content("1999-10-20")
  end
end
