module Api
  module V1
    class CardsController < ApplicationController
      before_action :set_list
      before_action :set_card, only: [:show, :update, :destroy]
      after_action :verify_policy_scoped, only: :index

      # GET /cards
      def index
        @cards = policy_scope(Card)
        authorize(@cards)
        render json: @cards, status: :ok
      end

      # GET /cards/1
      def show
        authorize(@card)
        render json: @card,  status: :ok
      end

      # POST /cards
      def create
        @card = @list.cards.new(card_params.merge(created_by: current_user.id))
        authorize @card
        if @card.save
          render json: { message: 'Card created successfully' }, status: :created
        else
          render json: @card.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /cards/1
      def update
        authorize @card
        if @card.update(card_params)
          render json: { message: 'Card updated successfully' }, status: :ok
        else
          render json: @card.errors, status: :unprocessable_entity
        end
      end

      # DELETE /cards/1
      def destroy
        authorize @card
        if @card.destroy
          render json: { message: 'Card deleted successfully' }, status: :ok
        else
          render json: @card.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_card
          @card = @list.cards.find(params[:id])
        end

        def set_list
          @list = List.includes(:cards).find(params[:list_id])
        end

        # Only allow a trusted parameter "white list" through.
        def card_params
          params.permit(:title, :description, :created_by, :list_id)
        end
    end
  end
end
