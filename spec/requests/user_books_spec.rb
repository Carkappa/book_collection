require 'rails_helper'

RSpec.describe "/user_books", type: :request do
  let(:user) { User.create!(username: "alice") }
  let(:book) do
    Book.create!(title: "The Pragmatic Programmer", author: "Andy Hunt", price: 39.99, published_date: Date.new(1999, 10, 20))
  end
  let(:other_book) do
    Book.create!(title: "Refactoring", author: "Martin Fowler", price: 49.99, published_date: Date.new(2018, 11, 20))
  end

  let(:valid_attributes) { { user_id: user.id, book_id: book.id } }
  let(:invalid_attributes) { { user_id: nil, book_id: book.id } }

  describe "GET /" do
    it "renders the User Books page with links to books, users, and new user book" do
      get root_url
      expect(response).to be_successful
      expect(response.body).to include("<h1>User Books</h1>")
      expect(response.body).to include(%(href="#{books_path}"))
      expect(response.body).to include(%(href="#{users_path}"))
      expect(response.body).to include(%(href="#{new_user_book_path}"))
    end
  end

  describe "GET /index" do
    it "shows each user book's username and book title" do
      UserBook.create! valid_attributes
      get user_books_url
      expect(response).to be_successful
      expect(response.body).to include("alice")
      expect(response.body).to include("The Pragmatic Programmer")
    end
  end

  describe "GET /show" do
    it "shows the username and book title" do
      user_book = UserBook.create! valid_attributes
      get user_book_url(user_book)
      expect(response).to be_successful
      expect(response.body).to include("alice")
      expect(response.body).to include("The Pragmatic Programmer")
    end
  end

  describe "GET /new" do
    it "renders drop-downs listing users and books" do
      user
      book
      get new_user_book_url
      expect(response).to be_successful
      expect(response.body).to include(%(<option value="#{user.id}">alice</option>))
      expect(response.body).to include(%(<option value="#{book.id}">The Pragmatic Programmer</option>))
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      user_book = UserBook.create! valid_attributes
      get edit_user_book_url(user_book)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UserBook" do
        expect {
          post user_books_url, params: { user_book: valid_attributes }
        }.to change(UserBook, :count).by(1)
      end

      it "redirects to the created user_book" do
        post user_books_url, params: { user_book: valid_attributes }
        expect(response).to redirect_to(user_book_url(UserBook.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UserBook" do
        expect {
          post user_books_url, params: { user_book: invalid_attributes }
        }.to change(UserBook, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_books_url, params: { user_book: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested user_book" do
        user_book = UserBook.create! valid_attributes
        patch user_book_url(user_book), params: { user_book: { book_id: other_book.id } }
        expect(user_book.reload.book).to eq(other_book)
      end

      it "redirects to the user_book" do
        user_book = UserBook.create! valid_attributes
        patch user_book_url(user_book), params: { user_book: { book_id: other_book.id } }
        expect(response).to redirect_to(user_book_url(user_book))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        user_book = UserBook.create! valid_attributes
        patch user_book_url(user_book), params: { user_book: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user_book" do
      user_book = UserBook.create! valid_attributes
      expect {
        delete user_book_url(user_book)
      }.to change(UserBook, :count).by(-1)
    end

    it "redirects to the user_books list" do
      user_book = UserBook.create! valid_attributes
      delete user_book_url(user_book)
      expect(response).to redirect_to(user_books_url)
    end
  end
end
