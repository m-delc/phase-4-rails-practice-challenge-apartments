class LeasesController < ApplicationController

    def create
        lease = Lease.create!(lease_params)
        if lease
            return render json: lease, status: 201, except: [:created_at, :updated_at]
        else
            return render json: {error: "Lease not created" }, status: 404
        end
    rescue ActiveRecord::RecordInvalid => invalid
        return render json: {errors: invalid.record.errors.full_messages}, status: 422
    end

    def destroy
        lease = find_by_id
        if lease
            lease.destroy
            return render json: {}
        else 
            return render json: {error: "No lease to destroy"}, status: 404
        end
    end

    # def index
    #     lease = Lease.all
    #     render json: lease, staus: 200
    # end


    private

    def find_by_id
        lease = Lease.find_by(id: params[:id])
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
