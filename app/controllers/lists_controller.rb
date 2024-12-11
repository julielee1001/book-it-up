class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = List.all
    flash[:notice] = "No lists available yet!" if @lists.empty?
  end

  def show
    @list = List.find(params[:id])
    @books = @list.books
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.new(list_params)
    @list.status = :personal

    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

    def edit
      @list = current_user.lists.find(params[:id])
    end

    def update
      @list = current_user.lists.find(params[:id])

      if @list.update(list_params)
          redirect_to @list
      else
          render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @list = List.find(params[:id])
      @list.destroy

      redirect_to lists_path, status: :see_other, notice: "List successfully deleted!"
    end

    def remove_book_from_list
      @list = List.find(params[:id])
      @book = Book.find(params[:book_id])

      @book_list = BookList.find_by(list_id: @list.id, book_id: @book.id)

      if @book_list
        @book_list.destroy
        redirect_to @list, notice: "Book removed from list!"
      else
        redirect_to @list, alert: "This book is not associated with the list!"
      end
    end

    def purge_picture
      @list = List.find(params[:id])
      @list.picture.purge
      redirect_to list_path(@list), notice: "Picture Deleted Successfully!"
    end

  private
    def list_params
        params.require(:list).permit(:name, :description, :id, :picture)
    end
end
