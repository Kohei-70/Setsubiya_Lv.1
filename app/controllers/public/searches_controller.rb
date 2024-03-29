class Public::SearchesController < ApplicationController
  # 権限の設定
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
    @quizzes = Quiz.search_for(@quiz_title, @method, @model).page(params[:page])
  end

  def quiz
    @search_quiz = Quiz.find(params[:id])
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
  end

  def answer
    @quiz = Quiz.find(params[:id])
    user_answer = params[:answer]
    @answer_record = AnswerRecord.new
    @answer_record.quiz_id = @quiz.id
    @answer_record.user_id = current_user.id
    @answer_record.answer = user_answer.to_i
    @answer_record.save

    if @answer_record.answer == @quiz.answer
      @result = 'correct.svg'
    else
      @result = 'incorrect.svg'
    end

    @quiz_comment = QuizComment.new
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
  end

end