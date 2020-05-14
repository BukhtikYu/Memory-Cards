# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to @card, notice: 'Card was succsesfully created'
    else
      render 'new'
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def index
    @cards = Card.all.sort_by(&:id)
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was succsesfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path, notice: 'Card was succsesfully deleted'
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer)
  end

end
