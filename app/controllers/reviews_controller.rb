class ReviewsController < ApplicationController
  before_action :set_service, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.service = @service
    if @review.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
      # this is when you fail to book, you will come back to new booking page
    end
  end

  private

  def set_service
    @service = service.find(params[:service_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
