module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request

      def login
        command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          render json: { auth_token: command.result }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end

      def logout;end

      def signup
        @user = User.new(user_params)
        # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
        @user.email.downcase!
        if @user.save
          response = { message: 'User created successfully'}
          render json: response, status: :created
        else
          render json: @user.errors, status: :bad
        end
      end

      private

      def user_params
        params.permit(
          :username,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
