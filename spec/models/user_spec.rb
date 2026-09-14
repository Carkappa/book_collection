require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(username: "alice") }
  let(:book) do
    Book.create!(title: "The Pragmatic Programmer", author: "Andy Hunt", price: 39.99, published_date: Date.new(1999, 10, 20))
  end

  describe "associations" do
    it "has many books through user_books" do
      UserBook.create!(user: user, book: book)
      expect(user.books).to contain_exactly(book)
    end

    it "removes its user_books when destroyed, but keeps the books" do
      UserBook.create!(user: user, book: book)
      expect { user.destroy }.to change(UserBook, :count).by(-1)
      expect(Book.exists?(book.id)).to be(true)
    end
  end
end
