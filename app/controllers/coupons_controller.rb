# encoding: utf-8
class CouponsController < ApplicationController
  # GET /coupons
  # GET /coupons.json
  def index
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 100
    @coupons = current_user.coupons.order("coupons.updated_at desc").page([params[:page].to_i,1].max).per(@per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupons }
    end
  end

  def search
    if params[:term].present?
      @coupons = current_user.coupons.where sn_code: params[:term]
    else
      @coupons = current_user.coupons.all
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupon = current_user.coupons.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.json
  def new
    @coupon = current_user.coupons.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = current_user.coupons.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = current_user.coupons.new(params[:coupon])

    respond_to do |format|
      #if @coupon.save
      if current_user.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render json: @coupon, status: :created, location: @coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.json
  def update
    @coupon = current_user.coupons.find(params[:id])
    params[:coupon][:used_at] = DateTime.now if params[:coupon][:status]=="已使用"

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon = current_user.coupons.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end
end
