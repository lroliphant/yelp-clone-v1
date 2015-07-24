class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  # def create
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @restaurant.reviews.create(review_params)
  #   redirect_to restaurants_path
  # end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        flash[:notice] = "You cannot review a restaurant twice"
        redirect_to restaurants_path
      else
        render :new
      end
    end
    # @restaurant.reviews.create(review_params)
    # redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
