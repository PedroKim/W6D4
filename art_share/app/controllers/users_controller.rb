# A controller manages requests that pertain to a collection of resources. 
# A resource is anything in your application that you will be CRUDing.
# CRUD - Create, Read, Update, Delete
class UsersController < ApplicationController
    # #params is a method provided by ActionController::Base that returns
    # a hash of all parameters available.

    def index
        render json: User.all
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        user = User.new(user_params)
        if user.save
            # render json: will automatically call to_json on the object
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        user = User.find(params[:id])

        if user.update(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        User.find(params[:id]).destroy
    end

    private
    def user_params
        params.require(:user).permit(:name, :email)
    end
end