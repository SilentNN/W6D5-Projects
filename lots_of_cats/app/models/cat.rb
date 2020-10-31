require 'action_view'


class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    COLORS = ['White', 'Black', 'Red', 'Grey', 'Cream', 'Brown', 'Cinnamon', 'Fawn']

    validates :birth_date, presence: true
    validates :color, presence: true, inclusion: {in: COLORS, message: '%{value} is not a valid color'}
    validates :name, presence: true
    validates :sex, presence: true, inclusion: {in: %w(M F), message: '%{value} is not a valid sex'}
    validates :description, presence: true
    

    def age
        time_ago_in_words(birth_date)
    end

    has_many :rental_requests,
        foreign_key: :cat_id,
        class_name: :CatRentalRequest,
        dependent: :destroy

end
