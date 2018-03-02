class ChannelsController < ApplicationController
  before_action :require_login
  before_action :channel, only: %i[show edit update destroy]
  before_action :users, only: %i[new edit create]
  before_action :can_contribute, only: [:show]

  def index
    @channels = Channel.all.select do |channel|
      channel.authorized_contributor?(current_user)
    end
  end

  def show
    @messages = channel.messages
    @message = Message.new
  end

  def new
    @channel = Channel.new
    @channel.private_conversations.build
  end

  def edit
  end

  def create
    new_params = massage_params(channel_params)
    @channel = Channel.new(new_params)

    if @channel.save
      redirect_to channel_path(channel)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if channel.update(massage_params(channel_params))
        format.html { redirect_to channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: channel }
      else
        format.html { render :edit }
        format.json { render json: channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def can_contribute
    redirect_to action: :index unless channel.authorized_contributor?(current_user)
  end

  def channel
    @channel ||= Channel.friendly.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:id, :private, :name,
                                    private_conversations_attributes: [user_id: []]
                                  )
  end

  def massage_params(params)
    new_params = params.merge({ user_id: current_user.id })

    if new_params['private'] == 'true'
      private_user_ids = new_params['private_conversations_attributes']['0']['user_id']

      private_conv_attr = {}.tap do |hash|
        private_user_ids.each_with_index do |user_id, index|
          hash[index.to_s.to_sym] = { user_id: user_id }
        end
      end

      new_params.merge({ private_conversations_attributes: private_conv_attr })
    else
      new_params
    end
  end

  def users
    @users ||= User.all
  end
end
