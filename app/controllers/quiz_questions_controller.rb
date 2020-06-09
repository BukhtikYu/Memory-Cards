# frozen_string_literal: true

class QuizQuestionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :get_quiz
  before_action :set_quiz_question, only: [:show, :edit, :update, :destroy]

  def new
    @quiz_question = @quiz.quiz_questions.build
  end

  def create
    @quiz_question = @quiz.quiz_questions.build(quiz_question_params)
    if @quiz_question.save
      redirect_to quiz_quiz_questions_path(@quiz.id), notice: 'Question was succsesfully created'
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @quiz_questions = @quiz.quiz_questions.sort_by(&:id)
  end

  def edit
  end

  def update
    if @quiz_question.update(quiz_question_params)
      redirect_to quiz_quiz_questions_path, notice: 'Question was succsesfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @quiz_question.destroy
    redirect_to quiz_quiz_questions_path, notice: 'Question was succsesfully deleted'
  end

  private

  def quiz_question_params
    params.require(:quiz_question).permit(:question, :quiz_id)
  end

  def get_quiz
    quiz = Quiz.find(params[:quiz_id])
    if quiz.user == current_user
      @quiz = quiz
    else
      no_access_quiz
    end
  end

  def set_quiz_question
    @quiz_question = @quiz.quiz_questions.find(params[:id])
  end
end
