module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, excpet: [:logout]

      def login
        command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          render json: { auth_token: command.result },status: :ok
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end

      def logout
        render json: { message: 'Logged out successfully' },status: :ok
      end

      def signup
        user_attr = user_params
        if user_attr.delete(:admin)
          user_attr[:role] = 'admin'
        end

        @user = User.new(user_attr)
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
          :password_confirmation,
          :admin
        )
      end
    end
  end
end
