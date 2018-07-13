class HomeController < ApplicationController
  def index
    @files = LoadLastImagesService.call
  end

  def inf_agronoma
  end
end
