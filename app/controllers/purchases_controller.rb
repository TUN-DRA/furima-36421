class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
    if @purchase_shipping_address.valid?
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping_address).permit(:purchase_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

 
