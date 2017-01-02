require 'test_helper'

class ListingAttachmentsControllerTest < ActionController::TestCase
  setup do
    @listing_attachment = listing_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listing_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listing_attachment" do
    assert_difference('ListingAttachment.count') do
      post :create, listing_attachment: { image: @listing_attachment.image, post_id: @listing_attachment.post_id }
    end

    assert_redirected_to listing_attachment_path(assigns(:listing_attachment))
  end

  test "should show listing_attachment" do
    get :show, id: @listing_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listing_attachment
    assert_response :success
  end

  test "should update listing_attachment" do
    patch :update, id: @listing_attachment, listing_attachment: { image: @listing_attachment.image, post_id: @listing_attachment.post_id }
    assert_redirected_to listing_attachment_path(assigns(:listing_attachment))
  end

  test "should destroy listing_attachment" do
    assert_difference('ListingAttachment.count', -1) do
      delete :destroy, id: @listing_attachment
    end

    assert_redirected_to listing_attachments_path
  end
end
