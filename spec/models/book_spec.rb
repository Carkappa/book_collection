require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:valid_attributes) {
    {
      title: "The Pragmatic Programmer",
      author: "Andy Hunt",
      price: 39.99,
      published_date: Date.new(1999, 10, 20)
    }
  }

  describe "validations" do
    it "is valid with a title" do
      expect(Book.new(valid_attributes.merge(title: "The Pragmatic Programmer"))).to be_valid
    end

    it "is invalid without a title" do
      book = Book.new(valid_attributes.merge(title: ""))
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it "is valid with an author" do
      expect(Book.new(valid_attributes.merge(author: "Andy Hunt"))).to be_valid
    end

    it "is invalid without an author" do
      book = Book.new(valid_attributes.merge(author: ""))
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end

    it "is valid with a price" do
      expect(Book.new(valid_attributes.merge(price: 39.99))).to be_valid
    end

    it "is invalid without a price" do
      book = Book.new(valid_attributes.merge(price: nil))
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("can't be blank")
    end

    it "is valid with a published date" do
      expect(Book.new(valid_attributes.merge(published_date: Date.new(1999, 10, 20)))).to be_valid
    end

    it "is invalid without a published date" do
      book = Book.new(valid_attributes.merge(published_date: nil))
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
    end
  end
end
