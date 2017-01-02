class ListingAttachmentsController < ApplicationController
  before_action :set_listing_attachment, only: [:show, :edit, :update, :destroy]

  # GET /listing_attachments
  # GET /listing_attachments.json
  def index
    @listing_attachments = ListingAttachment.all
  end

  # GET /listing_attachments/1
  # GET /listing_attachments/1.json
  def show
  end

  # GET /listing_attachments/new
  def new
    @listing_attachment = ListingAttachment.new
  end

  # GET /listing_attachments/1/edit
  def edit
  end

  # POST /listing_attachments
  # POST /listing_attachments.json
  def create
    @listing_attachment = ListingAttachment.new(listing_attachment_params)

    respond_to do |format|
      if @listing_attachment.save
        format.html { redirect_to @listing_attachment, notice: 'Listing attachment was successfully created.' }
        format.json { render :show, status: :created, location: @listing_attachment }
      else
        format.html { render :new }
        format.json { render json: @listing_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listing_attachments/1
  # PATCH/PUT /listing_attachments/1.json
  def update
    respond_to do |format|
      if @listing_attachment.update(listing_attachment_params)
        format.html { redirect_to @listing_attachment, notice: 'Listing attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing_attachment }
      else
        format.html { render :edit }
        format.json { render json: @listing_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listing_attachments/1
  # DELETE /listing_attachments/1.json
  def destroy
    byebug
    @listing_attachment = params
    @listing_attachment.destroy
    respond_to do |format|
      format.html { redirect_to listing_attachments_url, notice: 'Listing attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing_attachment
      @listing_attachment = ListingAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_attachment_params
      params.require(:listing_attachment).permit(:post_id, :image)
    end
end
