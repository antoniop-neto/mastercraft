class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      redirect_to @service, notice: 'Service was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def manage
    @user = current_user
    @services = current_user.services
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
  end

  private

  def service_params
    params.require(:service).permit(:name, :price, :address)
  end
end
