class Api::V1::BooksController < ApplicationController

  def index
    @books = Book.all
    render json: @books.to_json()
  end

  def show
    #Show page will display books based on google api id in URL rather than local id
    @book = Book.find_by(google_id: params[:id])
    render json: @book.to_json()
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    @book.save if @book.valid?
    render json: @book.to_json()
  end

  private

    #isbn not currently being used
    def book_params
      params.permit(:title, :author, :genre, :year, :description, :page_count, :google_id, :google_url, :thumbnail_url, :isbn_ten, :isbn_thirteen)
    end

    def find_book
      @book = Book.find(params[:id])
    end

end
