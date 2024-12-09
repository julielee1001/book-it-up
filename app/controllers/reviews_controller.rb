class ReviewsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @book = Book.find_by(id: params[:book_id])
      if @book.nil?
        redirect_to books_path, alert: "Book not found"
      else
        @review = Review.new
      end
    end
  
    def create
      @book = Book.find_by(id: params[:book_id])
      if @book.nil?
        redirect_to books_path, alert: "Book not found"
      else
        @review = @book.reviews.build(review_params)
        @review.user = current_user
  
        if @review.save
          redirect_to book_reviews_path(@book), notice: 'Review added successfully.'
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  
    def index
      @book = Book.find_by(id: params[:book_id])
      if @book.nil?
        redirect_to books_path, alert: "Book not found"
      else
        if params[:user_id].present? && params[:user_id] == current_user.id.to_s
          @reviews = current_user.reviews
        else
          @reviews = @book.reviews
        end
      end
    end

    def edit 
    end

    def update 
    end

    def 
  
    private
  
    def review_params
      params.require(:review).permit(:content, :id)
    end
  end
  