# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_board
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def new
    @card = @board.cards.build
  end

  def create
    @card = @board.cards.build(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to board_cards_path(@board), notice: 'Card was succsesfully created'
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @cards = @board.cards.sort_by(&:id)
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to board_cards_path(@board), notice: 'Card was succsesfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to board_cards_path(@board), notice: 'Card was succsesfully deleted'
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer)
  end

  def get_board
    @board = Board.find(params[:board_id])
  end

  def set_card
    @card = @board.cards.find(params[:id])
  end
end
