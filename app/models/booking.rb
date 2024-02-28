class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validate :end_date_after_start_date

  def calculate_price
    return unless start_date && end_date

    days = (end_date - start_date).to_i
    self.price = days * car.daily_price
  end
end

private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
