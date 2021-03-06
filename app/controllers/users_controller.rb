class UsersController < ApplicationController
  
  
    def show
        @user = User.includes(:stories).find(helpers.current_user.id)
    end
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        session[:user_id] = @user.id
        respond_to do |format|
          if @user.save
            format.html { redirect_to root_path, notice: 'User was successfully created.' }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end
     
        private
      # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end