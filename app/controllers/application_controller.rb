class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  # global rescue response
  rescue_from(
    ActiveRecord::RecordInvalid,
    with: :render_unprocessable_entity_response
  )
  rescue_from(
    ActiveRecord::RecordNotFound,
    with: :render_not_found_response
  )

  def render_unprocessable_entity_response(exception)
    msg =
      exception.record.errors.full_messages
    render json: msg, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
