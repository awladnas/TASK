module Api
  module V1
    class ListsController < ApplicationController
      before_action :set_list, only: [:show, :update, :destroy]

      # GET /lists
      def index
        @lists = List.includes(:cards)
        authorize @lists
        render json: @lists
      end

      # GET /lists/1
      def show
        authorize @list
        render json: @list
      end

      # POST /lists
      def create
        @list = current_user.own_lists.new(list_params)
        authorize @list
        if @list.save
          render json: { message: 'List created successfully' }, status: :created
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /lists/1
      def update
        authorize @list
        if @list.update(list_params)
          render json: { message: 'List updated successfully' }, status: :ok
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      # DELETE /lists/1
      def destroy
        authorize @list
        if @list.destroy
          render json: { message: 'List deleted successfully' }, status: :ok
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_list
          @list = List.includes(:cards).find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def list_params
          params.permit(:title, :created_by)
        end
    end
  end
end
