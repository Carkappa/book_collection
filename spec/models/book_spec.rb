require 'rails_helper'

RSpec.describe Book, type: :model do
  def errors_for(attribute, value)
    book = Book.new(attribute => value)
    book.valid?
    book.errors[attribute]
  end

  describe "title" do
    it "is valid when present" do
      expect(errors_for(:title, "The Pragmatic Programmer")).to be_empty
    end

    it "is invalid when blank" do
      expect(errors_for(:title, "")).to include("can't be blank")
    end
  end

  describe "author" do
    it "is valid when present" do
      expect(errors_for(:author, "Andy Hunt")).to be_empty
    end

    it "is invalid when blank" do
      expect(errors_for(:author, "")).to include("can't be blank")
    end
  end

  describe "price" do
    it "is valid when present" do
      expect(errors_for(:price, 39.99)).to be_empty
    end

    it "is invalid when blank" do
      expect(errors_for(:price, nil)).to include("can't be blank")
    end
  end

  describe "published_date" do
    it "is valid when present" do
      expect(errors_for(:published_date, Date.new(1999, 10, 20))).to be_empty
    end

    it "is invalid when blank" do
      expect(errors_for(:published_date, nil)).to include("can't be blank")
    end
  end
end
