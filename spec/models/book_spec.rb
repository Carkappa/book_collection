require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it "is valid with a title" do
      expect(Book.new(title: "The Pragmatic Programmer")).to be_valid
    end

    it "is invalid without a title" do
      book = Book.new(title: "")
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end
  end
end
