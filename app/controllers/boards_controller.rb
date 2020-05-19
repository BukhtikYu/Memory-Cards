# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_board
  
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to boards_path, notice: 'Board was succsesfully created'
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @boards = Board.all.where(user: current_user).sort_by(&:id)
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: 'Board was succsesfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: 'Board was succsesfully deleted'
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
    redirect_to boards_path, alert: 'Invalid board'
  end

  def no_access_board
    redirect_to boards_path, alert: 'No access'
  end
end