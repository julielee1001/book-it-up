class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = List.all
    flash[:notice] = "No lists available yet!" if @lists.empty?
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end 

  def create
    @list = List.new(list_params)
    @list.status = :personal

    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end

    def edit
      @list = List.find(params[:id])
    end 

    def update
      @list = List.find(params[:id])

      if @list.update(list_params)
          redirect_to @list
      else
          render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @list = List.find(params[:id])
      @list.destroy

      redirect_to root_path, status: :see_other
    end

  end

  private
    def list_params
        params.require(:list).permit(:name, :description, :id)
    end
end
