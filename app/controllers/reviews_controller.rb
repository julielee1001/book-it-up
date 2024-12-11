class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_review_owner, only: [ :edit, :update, :destroy ]

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

    def show
        @book = Book.find_by(id: params[:book_id])
        @review = @book.reviews.find(params[:id])
    end

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
            redirect_to book_reviews_path(@book), notice: "Review added successfully."
          else
            render :new, status: :unprocessable_entity
          end
        end
      end

    def edit
        @book = Book.find(params[:book_id])
        @review = @book.reviews.find(params[:id])
    end

    def update
        @book = Book.find(params[:book_id])
        @review = @book.reviews.find(params[:id])

        if @review.update(review_params)
            redirect_to book_reviews_path(@book), notice: "Review successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @book = Book.find(params[:book_id])
        @review = @book.reviews.find(params[:id])
        @review.destroy

        redirect_to book_reviews_path(@book), notice: "Review deleted successfully.", status: :see_other
    end

    def my_reviews
        @reviews = current_user.reviews
        @reviews = Review.order(created_at: :desc)
    end

    def authorize_review_owner
        @book = Book.find(params[:book_id])
        @review = @book.reviews.find(params[:id])
        unless @review.user == current_user
          redirect_to book_reviews_path(@book), notice: "You are not authorized to perform this action."
        end
    end

    private

    def review_params
      params.require(:review).permit(:content, :id)
    end
end
