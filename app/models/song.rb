class Song < ApplicationRecord

    validates :title, presence: true
    validates :title, uniqueness: {
        scope: %i[release_year artist_name],
        message: 'cannot be repeated by the same artist in the same year'
      }
    validates :released, inclusion: { in: [true, false]}

    validates :release_year, presence: true, if: :not_blank?
    validate  :release_year_cannot_be_in_future

    validates :artist_name, presence: true

    def not_blank?
        released
    end

    def release_year_cannot_be_in_future
        if release_year.present? && release_year > Date.today.year
            errors.add(:release_year, "Year must be this year, or before")
        end
    end

end
