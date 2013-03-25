class ImagesController < ApplicationController
  # GET /images
  # GET /images.json
  def index
    page = (params[:page] || 1).to_i
    per_page = 16

    if (params[:name])
      id = Category.where(:name => params[:name])[0].id
      @images = Image.paginate_by_sql(
        ['SELECT "images".* FROM "images" INNER JOIN "categories_images" ON
         "images"."id" = "categories_images"."image_id" WHERE "categories_images"."category_id" = ' + id.to_s],
         :page => page,
         :order => 'id DESC',
         :per_page => per_page
      )
      @category = params[:name]
      count = Category.where(:name => params[:name])[0].images.count
    else
      @images = Image.paginate(:page => params[:page], :per_page => per_page, :order => 'id DESC')
      count = Image.count
    end

    @next = page + 1
    @previous = page - 1

    @next = nil if page*per_page >= count
    @previous = nil if @previous < 1

    respond_to do |format|
      format.html
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    @previous = @image.previous_image
    @next = @image.next_image

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end
end
