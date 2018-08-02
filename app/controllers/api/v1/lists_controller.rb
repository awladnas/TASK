module Api
  module V1
    class ListsController < ApplicationController
      before_action :set_list, only: [:show, :update, :destroy, :assign_member, :unassign_member]
      after_action :verify_policy_scoped, only: :index

      # GET /lists
      def index
        @lists = policy_scope(List)
        # @lists = List.includes(:cards)
        authorize @lists
        render json: @lists, status: :ok
      end

      # GET /lists/1
      def show
        authorize @list
        render json: @list,include: :cards, status: :ok
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

      def assign_member
        authorize @list
        list_user = @list.list_users.find_or_initialize_by(user_id: params[:member_id])
        if list_user.id
          render json: { message: 'member already added' }, status: :ok
        elsif list_user.save
          render json: { message: 'member added successfully' }, status: :ok
        else
          render json: list_user.errors, status: :unprocessable_entity
        end
      end

      def unassign_member
        authorize @list
        list_user = @list.list_users.find_by(user_id: params[:member_id])
        if list_user&.destroy
          render json: { message: 'member deleted successfully' }, status: :ok
        else
          render json: list_user&.errors, status: :unprocessable_entity
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
