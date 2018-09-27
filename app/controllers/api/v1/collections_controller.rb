class Api::V1::CollectionsController < ApplicationController

  def index
    if params[:user_id]
      @collections = User.find(params[:user_id]).collections
    else
      @collections = Collection.all
    end
    render json: @collections.to_json()
  end

  def new
    @collection = Collection.new
  end

  def show
    @collection = Collection.find(params[:id])
    @collection_with_books = @collection.books
    render json: @collection_with_books.to_json()
  end

  def create
    @collection = Collection.create(collection_params)
    @collection.save if @collection.valid?
    render json: @collection.to_json()
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update(collection_params)
      render json: @collection
    else
      render json: { errors: @collection.errors.full_message }, status: :unprocessible_entity
    end
  end

  private

    def collection_params
      params.permit(:name, :user_id)
    end

    def find_collection
      @collection = Collection.find(params[:id])
    end

end
