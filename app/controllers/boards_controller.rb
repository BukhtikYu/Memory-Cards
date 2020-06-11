# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy, :learning, :learning_random, :mark_down, :mark_up, :custom_sort]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_board

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to boards_path, notice: t('controllers.boards.create')
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @boards = Board.all.where(user: current_user).sort_by(&:id)
    @boards.each do |board|
      board.confidence_board = ConfidenceCounter.new(board).count_board_confidence
      board.save
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: t('controllers.boards.update')
    else
      render 'edit'
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: t('controllers.boards.destroy')
  end

  def learning
    @cards = @board.cards.sort_by(&:confidence_level_before_type_cast)
  end

  def learning_random
    @cards = @board.cards.shuffle
  end

  def mark_down
    @cards = @board.cards.sort_by(&:confidence_level_before_type_cast)
    respond_to do |format|
      format.js
    end
  end

  def mark_up
    @cards = @board.cards.sort_by(&:confidence_level_before_type_cast).reverse
    respond_to do |format|
      format.js
    end
  end

  def custom_sort
    @cards = @board.cards
    respond_to do |format|
      format.js
    end
  end

  def update_confidence_from_learning
    @board = Board.find(params[:board_id])
    @card = Card.find(params[:id])
    @current_confidence = @board.confidence_board
    respond_to do |format|
      if @card.update(params.permit(:confidence_level))
        @board.confidence_board = ConfidenceCounter.new(@board).count_board_confidence
        @board.save
        format.js
      end
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end

  def set_board
    board = Board.find(params[:id])
    if board.user == current_user
      @board = board
    else
      no_access_board
    end
  end

  def invalid_board
    redirect_to boards_path, alert: t('controllers.boards.invalid')
  end

  def no_access_board
    redirect_to boards_path, alert: t('controllers.boards.no_access')
  end
end
