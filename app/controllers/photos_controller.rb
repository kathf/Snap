class PhotosController < ApplicationController
  before_action :set_album
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :favourite]

  # GET /photos
  # GET /photos.json
  def index
    @photos = @album.photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo.increment!(:views)
  end

  def favourite
    @photo.toggle!(:favourite)
    redirect_to album_photo_path(@album, @photo)
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @album.photos.build(photo_params)
    if @photo.save
      redirect_to album_photos_path(@album), notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    if @photo.update(photo_params)
      redirect_to [@album, @photo], notice: 'Photo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    redirect_to album_photos_url(@album), notice: 'Photo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :description, :favourite)
    end

    def set_album
      @album = Album.find(params[:album_id])
    end
end
