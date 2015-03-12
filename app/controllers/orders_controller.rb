class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #this will make sure that only user that are signed in will be able to place orders
  before_action :authenticate_user!

# We want to make sure that all the orders are currently to the user. The .order("created_at" is for displaying
# those orders when thay where created in descinding order
 def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end


  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    #This line tell rails it can find the id we want to buy in the url
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user


    @order.listing_id = @listing.id
    # ths line will tell rails to get the user id an put it in the order file
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id


    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
