class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
      Rails.logger.puts params[:image_id].inspect
    if (params[:image_id])
      @categories = Image.find(params[:image_id]).categories
    else
      @categories = Category.all
    end

    # Serve the categories as a json with all their names
    @categories.map! do |c| c.name end

    respond_to do |format|
      format.json { render json: @categories}
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.where(:name => params[:id])[0]
    @images = @category.images

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.find_or_create_by_name params[:name]
    @image = Image.find(params[:image_id])

    if @category.save
      @image.categories << @category
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    # Delete category from an image
    @category = Category.where(:name => params[:name])
    @image = Image.find(params[:image_id])

    @image.categories -= @category

    # If the category has no more images, delete ir
    if @category.first.images.size == 0
      @category.first.delete
    end

    redirect_to @image
  end
end
