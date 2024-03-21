class ServicesController < ApplicationController
  def index
    @services = Service.all
    if params[:query].present?
      sql_subquery = <<~SQL
        services.name @@ :query
        OR services.address @@ :query
        OR users.last_name @@ :query
        OR users.first_name @@ :query
      SQL
      @services = @services.joins(:user).where(sql_subquery, query: params[:query])
    end
  end

  def show
    @service = Service.find(params[:id])
    @dayslots = @service.user.dayslots.order(:date)
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
    params.require(:service).permit(:name, :price, :address, :photo)
  end
end
