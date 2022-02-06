class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all
        render json: apartments, only: [:number, :id], include: {leases: {except: ["created_at", "updated_at"]}}
    end

    def show
        apartment = find_by_id
        if apartment
            return render json: apartment, only: [:number, :id], status: 200
        else
            return render json: { error: "No such apartment" }, status: 404
        end
    end

    def create
        apartment = Apartment.create!(apartment_params)
        if apartment
            return render json: apartment, only: [:number, :id], status: 201
        else 
            return render json: { error: "No apartment created" }, status: 404
        end
    rescue ActiveRecord::RecordInvalid => invalid
        return render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

    def update
        apartment = find_by_id
        if apartment
            apartment.update!(apartment_params)
            return render json: apartment, only: [:number, :id], status: 201
        else
            return render json: { error: "No such apartment" }, status: 404
        end
    rescue ActiveRecord::RecordInvalid => invalid
        return render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

    def destroy
        apartment = find_by_id
        if apartment
            apartment.destroy
            return render json: {}
        else 
            return render json: { error: "No such apartment" }, status: 404
        end        
    end

    private

    def find_by_id
        apartment = Apartment.find_by(id: params[:id])        
    end

    def apartment_params
        params.permit(:number)
    end

    # def render_apartment
    #     return render json: @apartment, only: [:number, :id]
    # end

end
