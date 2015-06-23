class AllPhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

end
