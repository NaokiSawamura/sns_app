class UsersController < ApplicationController
  before_action :authenticate_user!, except: :edit
  def index
    @users=User.where.not(id: current_user.id).order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @user=User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @posts = @user.posts.page(params[:page]).per(5).order("created_at DESC")
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(user_params)
  #     flash[:success] = "Profile updated"
  #     redirect_to @user
  #   else
  #     render :edit
  #   end
  # end

  def dmRoom
    @user = current_user
    @currentEntries = current_user.entries
    dmRoomIds = []
    
    @currentEntries.each do |entry|
    dmRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: dmRoomIds).where.not(user_id: @user).order(created_at: :desc).page(params[:page]).per(5)
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  def after_login
    current_user.update(first_sign_in_at: current_user.current_sign_in_at) unless current_user.first_sign_in_at
  end

end

