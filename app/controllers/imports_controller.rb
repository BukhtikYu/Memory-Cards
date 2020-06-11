# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_import, only: [:destroy]

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
        format.html { redirect_to imports_path, notice: t('controllers.imports.create') }
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
    @import.destroy
    redirect_to imports_path, notice: t('controllers.imports.destroy')
  end

  private

  def set_import
    @import = Import.find(params[:id])
  end

  def import_params
    params.require(:import).permit(:file)
  end
end
