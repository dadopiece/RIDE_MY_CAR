class BookingsController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @booking = Booking.new
  end

  def create
    @car = Car.find(params[:car_id])
    @booking = Booking.new(booking_params)
    @booking.car = @car
    @booking.user = current_user
    @booking.calculate_price # Appel de la méthode pour calculer le prix

    if @booking.save
      redirect_to bookings_path, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @bookings = Booking.all.select{|booking| booking.user == current_user}
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
