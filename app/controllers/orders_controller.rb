class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index 
    @orders = current_user.orders.order(id: :desc)
  end

  def create     
    
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_items.build(sku_id: item.sku_id, quantity: item.quantity)
    end

    if @order.save
      service = LinepayService.new('payments/request')
      service.perform({
        productName: "大滷蛋",
        amount: current_cart.cart_total_price.to_i,
        currency: "TWD",
        confirmUrl: "http://localhost:3000/orders/confirm",
        orderId: @order.num
      })

      if service.is_success? 
        redirect_to service.payment_url
      else
        flash[:notice] = '付款發生錯誤'
        render 'carts/checkout'
      end  
    else  
      render html: @order.order_items.count
    end
    
  end


  def confirm 
    service = LinepayService.new("payments/#{params[:transactionId]}/confirm")
    service.perform({
      amount: current_cart.cart_total_price.to_i,
      currency: "TWD",
    })

    if service.is_success? 
      order_id = service.order_id
      p order_id
      transaction_id = params[:transactionId]

      order = current_user.orders.find_by(num: order_id)
      order.pay!(transaction_id: transaction_id)

      session[:cart_rhino] = nil

      redirect_to root_path, notice: '付款已完成'
    else
      redirect_to root_path, notice: '付款發生錯誤'
    end

  end

  def cancel
    @order = current_user.orders.find(params[:id])

    if @order.paid?
      service = LinepayService.new("payments/#{@order.transaction_id}/refund")
      service.perform({})

      if service.is_success? 
        @order.cancel!
        redirect_to orders_path, notice: "訂單 #{@order.num} 已取消，並完成退款"
      else
        redirect_to orders_path, notice: "退款發生錯誤"
      end  

    else
      @order.cancel!
      redirect_to orders_path, notice: "訂單 #{@order.num} 已取消！"
    end

  end

  def pay 
    @order = current_user.orders.find(params[:id])

    service = LinepayService.new("payments/request")
    service.perform({
      productName: "大滷蛋",
      amount: @order.total_price.to_i,
      currency: "TWD",
      confirmUrl: "http://localhost:3000/orders/#{@order.id}/pay_confirm",
      orderId: @order.num
    })

    if service.is_success? 
      payment_url = service.payment_url
      redirect_to payment_url
    else
      redirect_to orders_path, notice: '付款發生錯誤'
    end  

  end

  def pay_confirm 
    @order = current_user.orders.find(params[:id])

    service = LinepayService.new("payments/#{params[:transactionId]}/confirm")
    service.perform({
      amount: @order.total_price.to_i,
      currency: "TWD",
    })

    if service.is_success? 
      transaction_id = service.transaction_id

      @order.pay!(transaction_id: transaction_id)

      redirect_to orders_path, notice: '付款已完成'
    else
      redirect_to orders_path, notice: '付款發生錯誤'
    end

  end

  private
  def order_params 
    params.require(:order).permit(:recipient, :tel, :address, :note)
  end

end
