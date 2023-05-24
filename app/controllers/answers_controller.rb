class AnswersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @questions = Question.all
    #@questions = Question.includes(:product_batch, :user).where(hidden: false)
    

    @product_batches = ProductBatch.where(questions: { product_batch_id: params[:product_batch_id] })
    #@answers = Answer.includes(:question).where(questions: { product_batch_id: params[:product_batch_id] })
   
  end
  

  def new
    @question = Question.includes(:product_batch, :user).find(params[:question_id])
    @answer = @question.answers.build
  end

  

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_admin
    @answer.product_batch = @question.product_batch

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
