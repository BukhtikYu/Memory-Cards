# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    render layout: 'homepage'
  end
end
