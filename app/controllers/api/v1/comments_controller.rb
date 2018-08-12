class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /api/v1/comments
  def index
    if params[:card_id]
      @comments = Card.includes(:comments).find(params[:card_id]).card_comments
    elsif params[:comment_id]
      comment = Comment.includes(:replies).find(params[:comment_id])
      @comments = comment.all_replies(comment)
    else
      @comments = current_user.cards.last.card_comments
    end

    # authorize(@comments)
    render json: @comments, status: :ok
  end

  # GET /api/v1/comments/1
  def show
    authorize(@comment)
    render json: @comment.all_replies(@comment), include: :replies, status: :ok
  end

  # POST /api/v1/comments
  def create
    @comment = Comment.new(comment_params)
    authorize(@comment)
    if @comment.save
      render json: {message: 'Comment created successfully.'}, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/comments/1
  def update
    if @api_v1_comment.update(api_v1_comment_params)
      render json: @api_v1_comment
    else
      render json: @api_v1_comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/comments/1
  def destroy
    @api_v1_comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit(:content, :parent_id, :card_id)
    end
end
