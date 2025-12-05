class UsersController < ApplicationController
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      admin: params[:admin]
    )

    if user.save
      render json: { message: "User created successfully" }, status: :created # 201 created
    else
      render json: { errors: user.errors }, status: :bad_request # 400
    end
  end
end
