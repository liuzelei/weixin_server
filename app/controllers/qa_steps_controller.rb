# encoding: utf-8
class QaStepsController < ApplicationController
  def index
    @steps = QaStep.all
  end
end
