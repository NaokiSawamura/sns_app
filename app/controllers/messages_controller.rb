class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      if @message.save
        respond_to do |format|
          format.html {redirect_to "/rooms/#{@message.room_id}", notice: 'メッセージが送信されました'}
          format.json {}
        end
      else
        render :index
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end  
end