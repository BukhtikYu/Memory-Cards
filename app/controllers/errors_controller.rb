# frozen_string_literal: true

class ErrorsController < ApplicationController
  # skip_before_action :authenticate_user!
  # before_action :authenticate_user!

  def not_found
    respond_to do |format|
      format.html { render status: 404, layout: false }
    end
  end

  def unacceptable
    respond_to do |format|
      format.html { render status: 422, layout: false }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render status: 500, layout: false }
    end
  end
end
