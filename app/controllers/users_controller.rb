class UsersController < Clearance::UsersController

  def index
    # @users = User.all
    if moderator?
      @users = User.page.per(10) #params[:page]
    else
      flash[:error] = "Unauthorized access"
      redirect_to root_path
    end    
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def edit
    if owner?
    @user = User.find(params[:id])
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_from_params)
    redirect_to @user
  end

  def create
    @user = User.new(user_from_params)
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      respond_to do |format|
        format.html {render :new}
        format.js
      end
    end
  end

  private
  def user_from_params
    params.require(:user).permit(:name, :email, :password)
  end

end

    # respond_to do |format|
    #     if @user.save
    #         format.html { redirect_to @user, notice: 'Post was successfully created.'}
    #         format.json { render :show, status: :created, location: @user }
    #         format.js
    #     else
    #         format.html { render :new }
    #         format.json { render json: @user.errors, status: :unprocesssable_entity}
    #         format.js
    #     end
