# encoding: utf-8
class QaStepsController < ApplicationController
  def index
    @qa_steps = current_user.qa_steps.all
  end

  def show
    @qa_step = current_user.qa_steps.find params[:id]
  end

  def new
    @qa_step = current_user.qa_steps.new
  end

  def create
    @qa_step = current_user.qa_steps.new(params[:qa_step])

    #if @qa_step.save
    if current_user.save
      #redirect_to @qa_step, notice: 'successfully created.'
      redirect_to qa_steps_path, notice: 'successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @qa_step = current_user.qa_steps.find params[:id]
  end

  def update
    @qa_step = current_user.qa_steps.find params[:id]

      if @qa_step.update_attributes(params[:qa_step])
        redirect_to @qa_step
      else
        render action: "edit"
      end
  end

  def destroy
    @qa_step = current_user.qa_steps.find params[:id]
    @qa_step.destroy

    redirect_to qa_steps_path
  end
end
