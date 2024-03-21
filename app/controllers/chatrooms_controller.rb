class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :authorize_user!, only: [:show]

  def show
    # The messages will be loaded and displayed in the view
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def authorize_user!
    unless @chatroom.has_access?(current_user)
      redirect_to root_path, alert: "You do not have access to this chatroom."
    end
  end
end
