class TodoItemsController < ApplicationController
  def index
    @todo_items = TodoItem.all
  end

  def show
    @todo_item = TodoItem.find(params[:id])
  end

  def new
    @todo_item = TodoItem.new
  end

  def edit
    @todo_item = TodoItem.find(params[:id])
  end

  def create
    @todo_item = TodoItem.new(todo_items_params)

    if @todo_item.save
      redirect_to @todo_item
    else
      render 'new'
    end
  end

  def update
    @todo_item = TodoItem.find(params[:id])

    if @todo_item.update(todo_items_params)
      redirect_to @todo_item
    else
      render 'edit'
    end
  end

  def destroy
    @todo_item = TodoItem.find(params[:id])
    @todo_item.destroy

    redirect_to todo_items_path
  end

  private

  def todo_items_params
    params.require(:todo_item).permit(:title, :text, :due_date)
  end
end
