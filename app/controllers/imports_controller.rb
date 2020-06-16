# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_import, only: [:destroy, :create_csv]

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

  def create_csv
    csv = CsvImporter.new(import: @import, user: current_user)
    csv.card_create
    redirect_to boards_path, notice: t('controllers.imports.success')
  end

  def download_template
    attributes = %w[board_name question answer]
    csv_template = CSV.generate(headers: true) do |csv|
      csv << attributes
    end
    respond_to do |format|
      format.csv { send_data csv_template, filename: "import_template.csv" }
    end
  end

  private

  def set_import
    @import = Import.find(params[:id])
  end

  def import_params
    params.require(:import).permit(:file)
  end
end
