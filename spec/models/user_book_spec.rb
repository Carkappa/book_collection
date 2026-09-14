require 'rails_helper'

RSpec.describe UserBook, type: :model do
  let(:user) { User.create!(username: "alice") }
  let(:book) do
    Book.create!(title: "The Pragmatic Programmer", author: "Andy Hunt", price: 39.99, published_date: Date.new(1999, 10, 20))
  end

  describe "validations" do
    it "is valid with a user and a book" do
      expect(UserBook.new(user: user, book: book)).to be_valid
    end

    it "is invalid without a user" do
      user_book = UserBook.new(book: book)
      expect(user_book).not_to be_valid
      expect(user_book.errors[:user]).to include("must exist")
    end

    it "is invalid without a book" do
      user_book = UserBook.new(user: user)
      expect(user_book).not_to be_valid
      expect(user_book.errors[:book]).to include("must exist")
    end

    it "is invalid when the user already has that book" do
      UserBook.create!(user: user, book: book)
      duplicate = UserBook.new(user: user, book: book)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:book_id]).to include("is already in this user's collection")
    end
  end

  describe "book associations" do
    it "lets a book have many users through user_books" do
      UserBook.create!(user: user, book: book)
      expect(book.users).to contain_exactly(user)
    end

    it "removes a book's user_books when the book is destroyed, but keeps the users" do
      UserBook.create!(user: user, book: book)
      expect { book.destroy }.to change(UserBook, :count).by(-1)
      expect(User.exists?(user.id)).to be(true)
    end
  end
end
