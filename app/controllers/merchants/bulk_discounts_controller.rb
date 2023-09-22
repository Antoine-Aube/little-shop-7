class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
    
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
    # require 'pry';binding.pry
    if params[:name].present? && params[:percentage].present? && params[:item_threshold].present?
      @discount.update(discount_params)
      redirect_to merchant_bulk_discount_path(params[:merchant_id], params[:discount_id])
    elsif !params[:name].present? || !params[:percentage].present? || !params[:item_threshold].present?
      redirect_to edit_merchant_bulk_discount_path(params[:merchant_id], params[:discount_id])
      flash[:error] = "Discount not updated: Required information missing."
    end
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

  def destroy
    discount = BulkDiscount.find(params[:discount_id])
    discount.destroy
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private

  def discount_params
    params.permit(:name, :percentage, :item_threshold)
  end
end