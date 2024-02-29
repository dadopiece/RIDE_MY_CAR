class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @cars = Car.all
    @car = Car.new

    if params[:search].present?
      @cars = @cars.where("brand ILIKE ? OR model ILIKE ? OR address ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:brand].present?
      @cars = @cars.where('brand ILIKE ?', "%#{params[:brand]}%")
    end

    if params[:model].present?
      @cars = @cars.where('model ILIKE ?', "%#{params[:model]}%")
    end

    if params[:max_price].present?
      @cars = @cars.where('price <= ?', params[:max_price])
    end

    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {car: car})
      }
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
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessablesr_entity
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :price, :photo, :address)
  end
end
