class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @cars = Car.all
    @car = Car.new()

      if params[:brand].present?
        @cars = @cars.where('brand ILIKE ?', "%#{params[:brand]}%")
      end

      if params[:model].present?
        @cars = @cars.where('model ILIKE ?', "%#{params[:model]}%")
      end

      if params[:max_price].present?
        @cars = @cars.where('price <= ?', params[:max_price])
      end
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
  end

  def new
    @car = Car.new()
  end

  def create
    @car = Car.new(car_params.with_defaults(user_id: User.first.id))
    if @car.save
      redirect_to bookings_index_path(@car)
    else
      render :new, status: :unprocessablesr_entity
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :price, :photo)
  end
end
