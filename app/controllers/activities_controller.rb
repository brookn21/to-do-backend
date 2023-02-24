class ActivitiesController < ApplicationController
    
    def index
        activities = Activity.all
        render json: activities, except: [:created_at, :updated_at], status: :ok
    end
    
    def create
        activity = Activity.new( activity_params)
        if activity.valid?
            activity.save
            render json: activity, except: [:created_at, :updated_at], status: :created
        else
            render json: { errors: activity.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        activity = Activity.find_by( id: params[:id])
        if activity
            activity.destroy
            head :no_content
        else
            render json: { errors: ['Activity not found.']}, status: :not_found
        end
    end

    private

    def activity_params
        params.require( :activity ).permit(:user_id, :complete, :name) 
    end
end