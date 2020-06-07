# frozen_string_literal: true

class QuizzesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    if @quiz.save
      redirect_to quizzes_path, notice: 'Quiz was successfully created'
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @quizzes = Quiz.all.where(user: current_user).sort_by(&:id)
  end

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to quizzes_path, notice: 'Quiz was successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_path, notice: 'Quiz was successfully deleted'
  end

  private

  def set_board
    quiz = Quiz.find(params[:id])
    if quiz.user == current_user
      @quiz = quiz
    else
      no_access_quiz
    end
  end

  def quiz_params
    params.require(:quiz).permit(:name, :user_id)
  end
end
