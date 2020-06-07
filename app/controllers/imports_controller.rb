# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :authenticate_user!

  # GET /imports
  def index
    @imports = Import.all.where(user: current_user).sort_by(&:created_at)
  end

  # GET /imports/1
  def show
  end

  def new
    @import = Import.new
  end

  def edit
  end

  # POST /imports
  def create
    @import = Import.new(import_params)
    @import.user_id = current_user.id
    respond_to do |format|
      if @import.save
        format.html { redirect_to imports_path, notice: 'File was successfully uploaded.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /imports/1
  def update
  end

  # DELETE /imports/1
  def destroy
  end

  private

  def import_params
    params.require(:import).permit(:file)
  end
end
