class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  def parking_type
    @type = params["type"].titleize.gsub('-','')
    @businesses = Business.includes(:parking_options).where("parking_options.name" => @type).paginate(:page => params[:page])
    # puts @businesses.inspect
  end

  def neighborhood
    @name = params["name"].titleize.gsub('-','')
    @parking_type = params["parking_type"]
    @options = ParkingOption.all
    
    if @parking_type
      @businesses = Business.includes(:neighborhoods, :parking_options).where("neighborhoods.name" => @name, "parking_options.name" => @parking_type.titleize.gsub('-','')).paginate(:page => params[:page])
    else
      @businesses = Business.includes(:neighborhoods).where("neighborhoods.name" => @name).paginate(:page => params[:page])
    end
  end

  def category
    @name = params["name"].titleize.gsub('-','')
    @name = params["name"].titleize.gsub('-','')
    @parking_type = params["parking_type"]
    @options = ParkingOption.all

    if @parking_type
      @businesses = Business.includes(:categories, :parking_options).where("categories.name" => @name, "parking_options.name" => @parking_type.titleize.gsub('-','')).paginate(:page => params[:page])
    else
      @businesses = Business.includes(:categories).where("categories.name" => @name).paginate(:page => params[:page])
    end
  end

  def near
    @lat = params["lat"]
    @lng = params["lng"]
    @limit = params["limit"].to_i
    @distance = params["distance"].to_f
    
    if !@lat or !@lng
      @lat = request.location.data["latitude"]
      @lng = request.location.data["longitude"]
    end

    @businesses = Business.near([@lat, @lng], @distance).reorder('distance').limit(@limit)

    respond_with(@businesses)
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :image_url, :url, :mobile_url, :phone, :display_phone, :review_count, :rating, :rating_img_url_large, :snippet_text, :address, :display_address, :city, :state_code, :postal_code, :country_code, :cross_streets, :is_claimed, :lat, :lng, :parking_spaces)
    end
end
