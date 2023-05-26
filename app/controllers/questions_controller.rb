class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_admin, only: [ :destroy ]

  def new
    @product_batch = ProductBatch.find_by(id: params[:product_batch_id])
    @question = @product_batch.questions.build
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

  def destroy
    @question = Question.find(params[:id])
    @product_batch = @question.product_batch
    @question.destroy
    redirect_to product_batch_answers_path(product_batch_id: @product_batch.id), notice: 'Pergunta excluída com sucesso.'
  end
  
  private

  def question_params
    params.require(:question).permit(:content)
  end

  def check_admin
    redirect_to root_path, alert: 'Apenas usuários não administradores podem enviar perguntas.' unless admin_signed_in?
  end
end

