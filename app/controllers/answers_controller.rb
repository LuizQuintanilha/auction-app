class AnswersController < ApplicationController
  before_action :authenticate_admin!

  def index
    #@product_batch = ProductBatch.find(params[:product_batch_id])
  
    @questions = Question.includes(:product_batch, :user).where(hidden: false)
  end
  

  def new
    @question = Question.includes(:product_batch, :user).find(params[:question_id])
    @answer = Answer.new
  end
  

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_admin

    if @answer.content.blank?
      redirect_to questions_path, alert: 'A resposta não pode estar vazia.'
    else
      @answer.save
      redirect_to product_batch_answers_path(product_batch_id: @question.product_batch_id), notice: 'Resposta enviada com sucesso.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
