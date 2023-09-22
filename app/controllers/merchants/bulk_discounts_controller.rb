class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def show 
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
    
  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(discount_params)
    discount.save
    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    elsif !discount.save
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:error] = "Discount not created: Required information missing."
    end
  end

  private
  def discount_params
    params.permit(:name, :percentage, :item_threshold)
  end
end