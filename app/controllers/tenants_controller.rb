class TenantsController < ApplicationController

    def index
        tenant = Tenant.all
        render json: tenant, status: 200, except: [:created_at, :updated_at]
    end

    def show
        tenant = find_by_id
        if tenant
            return render json: tenant, status: 200, except: [:created_at, :updated_at]
        else
            return render json: { error: "Tenant not found" }, status: 404
        end
    end

    def create
        tenant = Tenant.create!(tenant_params)
        if tenant
            return render json: tenant, status: 201, except: [:created_at, :updated_at]
        else 
            return render json: { error: "Tenant not created" }, status: 404
        end
    rescue ActiveRecord::RecordInvalid => invalid
        return render json: { errors: invalid.record.errors.full_messages }, status:422
    end

    def update
        tenant = find_by_id
        if tenant
            tenant.update!(tenant_params)
            return render json: tenant, except: [:created_at, :updated_at], status: 202
        else
            return render json: { error: "No tenant to update" }, status: 404
        end
    rescue ActiveRecord::RecordInvalid => invalid
        return render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

    def destroy
        tenant = find_by_id
        if tenant
            tenant.destroy
            return render json: {}
        else
            return render json: { error: "No tenant found" }, status: 404
        end
    end

    private

    def find_by_id
        Tenant.find_by(id: params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
