class HomeController < ApplicationController
  def index
    @files = LoadLastImagesService.call.map{|img| img.full_path}
  end

  def inf_agronoma
  end
end
