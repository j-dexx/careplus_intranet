class SlidersController < ApplicationController

  # GET /sliders
  def index
    @sliders = Slider.all
  end

  # GET /sliders/1
  def show
    @slider = Slider.find(params[:id])
  end
end

