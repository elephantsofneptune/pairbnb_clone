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
    @listing_attachments = @listing.listing_attachments.all
    @reservation = Reservation.new
  end

  def new
    @listing = Listing.new
    @listing_attachment = @listing.listing_attachments.build
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    if @listing.save
      byebug
      params[:listing_attachments]['image'].each do |image|
          @listing.listing_attachments.create!(:image => image)
      end
      respond_to do |format|
          # format.html {redirect_to controller:'listings', action:'show', id:@listing.id, success:"SUCCESSFULLY CREATED!" }
          format.html {redirect_to @listing}
          format.js
      end
    else
        flash[:notice] = @listing.errors.full_messages
        render :new
    end
  end

  def edit
    if owner?
      @listing = Listing.find(params[:id])
      @listing_attachments = @listing.listing_attachments.all
    end
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    redirect_to(:back)
  end

  def destroy
      @listing = Listing.find(params[:id])
      @listing.destroy
      redirect_to(:back)
  end

  private
  def listing_params
    params.require(:listing).permit(
      :title, 
      :description, 
      :pax, 
      :country, 
      :address, 
      :tag_list, 
      :status, 
      listings_attachments_attributes: [:id, :post_id, :image]
      )
  end

end
