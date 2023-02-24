class UsersController < ApplicationController

    def profile 
        auth_token = request.headers['Authenticate']
        if auth_token
            token = JWT.decode( auth_token, ENV['JWT_TOKEN'])[0]
            user = User.find_by( id: token['user'] )
            render json: user, except: [:created_at, :updated_at], include: [:activities]
        else
            return nil
        end
    end
    
    def show
        user = User.find_by(id: params[:id])
        render json: user, except:[:created_at, :updated_at], include: [:activities], status: :ok
    end

    def create 
        user = User.new(user_params)
        if user.valid?
            user.save
            render json: user, except: [:created_at, :updated_at], status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require( :user ).permit( :email, :password, :first_name, :last_name, :username)
    end

end
