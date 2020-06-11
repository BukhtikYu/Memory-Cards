# frozen_string_literal: true

class AvatarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_avatar, only: [:destroy, :update]

  # GET /avatars
  # GET /avatars.json
  def index
    @avatars = Avatar.all.where(user: current_user).order(updated_at: :desc)
  end

  # GET /avatars/new
  def new
    @avatar = Avatar.new
  end

  def update
    @avatar.touch
    redirect_to avatars_url
   end

  # POST /avatars
  # POST /avatars.json
  def create
    @avatar = Avatar.new(avatar_params)
    @avatar.user_id = current_user.id

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to avatars_path, notice: t('controllers.avatars.create') }
        format.json { render :show, status: :created, location: @avatar }
      else
        format.html { render :new }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avatars/1
  # DELETE /avatars/1.json
  def destroy
    @avatar.destroy
    respond_to do |format|
      format.html { redirect_to avatars_url, notice: t('controllers.avatars.destroy') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_avatar
    @avatar = Avatar.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def avatar_params
    params.require(:avatar).permit(:image)
    # params.fetch(:avatar, {})
  end
end
