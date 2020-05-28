# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_board
  before_action :set_card, only: [:show, :edit, :update, :destroy, :update_confidence]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_card

  def new
    @card = @board.cards.build
  end

  def create
    @card = @board.cards.build(card_params)
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
      redirect_to board_card_path(@board, @card), notice: 'Card was succsesfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to board_cards_path(@board), notice: 'Card was succsesfully deleted'
  end

  def update_confidence
    respond_to do |format|
      format.js if @card.update(params.permit(:confidence_level))
    end
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer)
  end

  def get_board
    board = Board.find(params[:board_id])
    if board.user == current_user
      @board = board
    else
      no_access_board
    end
  end

  def set_card
    @card = @board.cards.find(params[:id])
  end

  def invalid_card
    redirect_to boards_path, alert: 'Invalid card'
  end

  def no_access_board
    redirect_to boards_path, alert: 'No access'
  end
end
