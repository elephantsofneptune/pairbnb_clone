class ListingsController < ApplicationController

  def index
    # @listings = Listing.all
    # @listings = Listing.order(:title).page params[:page]
    if moderator?
      @listings = Listing.page.per(5)
    else
      flash[:error] = "Unauthorized access"
      redirect_to root_path
    end

  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_from_params)
    @listing.user_id = current_user.id
    if @listing.save
        respond_to do |format|
            format.html {redirect_to @listing}
            format.js
        end
    else
        respond_to do |format|
            format.html {render :new}
            format.js
        end
    end
  end

  def edit
    if owner?
      @listing = Listing.find(params[:id])
    end
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_from_params)
    redirect_to(:back)
  end

  def destroy
      @listing = Listing.find(params[:id])
      @listing.destroy
      redirect_to(:back)
  end

  private
  def listing_from_params
    params.require(:listing).permit(:title, :description, :pax, :country, :address, :tag_list, :status, :image, :remote_image_url)
  end

end
