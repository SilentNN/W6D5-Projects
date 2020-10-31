class CatRentalRequest < ApplicationRecord
    validates :cat_id, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status"}

    belongs_to :cat

    def overlapping_requests
        CatRentalRequest
            .where("status = 'APPROVED'")
            .where("start_date < ?", end_date)
            .where("end_date > ?", start_date)
            .where("cat_id = ?", cat_id)
    end
end
