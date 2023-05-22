class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:create]

  def new
    @product_batch = ProductBatch.find_by(id: params[:product_batch_id])
    @question = Question.new
  end

  def create
    @product_batch = ProductBatch.find(params[:product_batch_id])
    @question = @product_batch.questions.build(question_params)
    @question.user = current_user

    if @question.content.blank?
      redirect_to product_batch_path(@product_batch), notice: 'Erro ao enviar a pergunta.'
    else 
      @question.save
      redirect_to product_batch_path(@product_batch), notice: 'Pergunta enviada com sucesso.'
    end
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end

  def check_admin
    redirect_to root_path, alert: 'Apenas usuários não administradores podem enviar perguntas.' if admin_signed_in?
  end
end

