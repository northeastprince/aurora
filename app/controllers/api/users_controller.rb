class Api::UsersController < ApiController
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      head :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :phone_number, :zip_code)
  end
end
