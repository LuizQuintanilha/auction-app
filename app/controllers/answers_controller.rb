class AnswersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @questions = Question.where(hidden: :false)
    @product_batch = ProductBatch.find_by(id: params[:product_batch_id])
  end
  
  def new
    @user = User.find_by(id: params[:user_id])
    @question = Question.includes(:user, :product_batch).find_by(id: params[:question_id])
    @product_batch = ProductBatch.find_by(id: params[:product_batch_id])
    @answer = Answer.new()
  end
      
  def create
    @user = User.find_by(id: params[:user_id])
    @question = Question.includes(:user, :product_batch).find_by(id: params[:question_id])
    @product_batch = ProductBatch.find_by(id: params[:product_batch_id])
    @answer = @question.build_answer(answer_params)
    @answer.product_batch_id = params[:product_batch_id]
    @answer.user_id = current_admin.id 
    @answer.question_id = @question.id
    @admin = current_admin
    if @answer.save
      @question.hidden
      redirect_to product_batch_answers_path(product_batch_id: @question.product_batch_id), notice: 'Resposta enviada com sucesso.'
    else
      flash[:notice] = 'A resposta não pode estar em branco ou ter menos que 6 caracteres.'
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :product_batch_id, :user_id, :question_id)
  end
end
