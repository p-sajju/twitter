class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      @current_user = user
    else
      render json: { success: false, code: "400", message: 'Username/Password incorrect.' }, status: :unprocessable_entity
    end
  end
end