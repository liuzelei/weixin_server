# encoding: utf-8
class QaStepsController < ApplicationController
  def index
    @qa_steps = QaStep.all
  end

  def show
    @qa_step = QaStep.find params[:id]
  end

  def new
    @qa_step = QaStep.new
  end

  def create
    @qa_step = QaStep.new(params[:qa_step])

    if @qa_step.save
      #redirect_to @qa_step, notice: 'successfully created.'
      redirect_to qa_steps_path, notice: 'successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @qa_step = QaStep.find params[:id]
  end

  def update
    @qa_step = QaStep.find params[:id]

      if @qa_step.update_attributes(params[:qa_step])
        redirect_to @qa_step
      else
        render action: "edit"
      end
  end

  def destroy
    @qa_step = QaStep.find params[:id]
    @qa_step.destroy

    redirect_to qa_steps_path
  end
end
