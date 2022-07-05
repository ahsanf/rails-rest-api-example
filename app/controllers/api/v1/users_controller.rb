class Api::V1::UsersController < ApplicationController
    #GET all users
    def index
        @users = User.all
        render json: @users
    end

    #show user
    def show
        @user = User.find(params[:id])
        render json: @user
    end

    #POST user
    def create
        @user = User.create(user_params)
        if  @user.save
            render json: @user
        else
            render error: {error: 'Unable to create user.'}, status: 400
        end
    end

    #PUT user
    def update 
        @user = User.find(params[:id])
        if @user 
            @user.update(user_params)
            render json: {message: 'User updated successfully.'}, status:200
        else
            render error: {error: 'Unable to update user.'}, status: 400
        end
    end
    
    #DELETE user
    def destroy
        @user = User.find(params[:id])
        if @user
            @user.destroy
            render json: {message: 'User deleted successfully.'},status:200
        else 
            render error: {error: 'Unable to destroy user.'}, status:400
        end
        
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end

end
