class Lease < ApplicationRecord
    belongs_to :tenant
    belongs_to :apartment
    validates :rent, presence: true
    # validates :tenant_id, presence: true
    # validates :apartment_id, presence: true
end
