require 'byebug'
class ListingsController < ApplicationController

  def index
    # @listings = Listing.order(:title).page params[:page]
    if moderator?
      @listings = Listing.page(params[:page]).per(5)
    else
      @listings = Listing.approved.page.per(5)
      # flash[:error] = "Unauthorized access"
      # redirect_to root_path
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @listing_attachments = @listing.listing_attachments.all
    @reservation = Reservation.new
  end

  # ======================== SEARCH =============================
  def search
    @listings = Listing.all
    
    @listings = @listings.approved
    @listings = @listings.country(search_params[:country]) if !search_params[:country].blank?
    @listings = @listings.pax(search_params[:pax]) if !search_params[:pax].blank?
    @listings = @listings.price(search_params[:price]) if !search_params[:price].blank?

	@listings = @listings.page(params[:page]).per(5)

    render action: :index
  end

  def approved
  	@listings = Listing.all
  	@listings = @listings.approved

  	@listings = @listings.page(params[:page]).per(5)

  	render action: :index
  end

  def pending
  	@listings = Listing.all
  	@listings = @listings.pending

  	@listings = @listings.page(params[:page]).per(5)

  	render action: :index
  end

  def denied
  	@listings = Listing.all
  	@listings = @listings.denied

  	@listings = @listings.page(params[:page]).per(5)

  	render action: :index
  end

  # =============================================================
  def new
    @listing = Listing.new
    @listing_attachment = @listing.listing_attachments.build
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    
    if @listing.save
      if params[:listing_attachments][:image]
        upload_images
      end

      redirect_to @listing, :flash => { :success => "Successfully created listing!" }
    else

      flash[:notice] = @listing.errors.full_messages
      render :new

    end
  end

  def edit
      @listing = Listing.find(params[:id])
      @listing_attachments = @listing.listing_attachments.all
  end

  def update
      @listing = Listing.find(params[:id])
      @listing.update(listing_params)
      upload_images

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
      :price,
      :status,
      :search_country,
      listings_attachments_attributes: [:id, :post_id, :image]
    )
  end

  def search_params
    params.require(:search).permit(
      :country,
      :pax,
      :price
    )
  end

  def upload_images
    if params[:listing_attachments].present?
      params[:listing_attachments][:image].each do |image|
          @listing.listing_attachments.create!(image: image)
      end
    else
      return false
    end
  end

end
