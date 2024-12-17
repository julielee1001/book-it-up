class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @books = Book.order(created_at: :desc)
    @lists = current_user.lists
  end

  def new
    require "httparty"

    if params[:search].present?

      api_key = Rails.application.credentials.google_books_api_key
      url = "https://www.googleapis.com/books/v1/volumes?q=#{params[:search]}&maxResults=15&key=#{api_key}"
      response = HTTParty.get(url)

      if response.success?

        @results = response.parsed_response["items"] || []
        flash[:message] = "No books found" if @results.empty?

      else
        flash[:message] = "There was a problem with the Google Books API."
        @results = []
      end

    else
      @results = []

    end
  end

  def create
    @book = Book.find_or_initialize_by(google_id: params[:google_id])

    if @book.new_record?
      @book.assign_attributes(
        title: params[:title],
        author: params[:author],
        description: params[:description],
        cover_url: params[:cover_url]
      )
    end

    if @book.save
      redirect_to books_path, notice: "Book successfully saved!"
    else
      redirect_to books_path, alert: "Book could not be saved."
    end
  end

  def show
    @book = Book.find_by(google_id: params[:id])

    if @book.nil?
      @book = {
        google_id: params[:id],
        title: params[:title],
        author: params[:author],
        description: params[:description],
        cover_url: params[:cover_url]
      }
    end
  end

  def show_all
    @book = Book.find(params[:id])
    @lists = current_user.lists
  end

  def add_to_list
    @book = Book.find(params[:id])
    @list = List.find(params[:list_id])

    if @book.lists.include?(@list)
      redirect_to books_path, notice: "Book is already in this list!"
    else
      @book.lists << @list
      redirect_to books_path, notice: "Book added to the list!"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book successfully deleted!"
  end

  private

  def book_params
    params.require(:book).permit(:author, :title, :description, :cover_url)
  end
end
