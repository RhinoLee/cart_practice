require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do 
    it "可把商品丟進購物車，購物車就會出現該商品" do 
      cart = Cart.new
      cart.add_item(2)
      expect(cart.empty?).to be false
    end

    it "加入相同的商品進購物車，購物車的購買項目不會增加，而是增加該商品數量" do 
      cart = Cart.new 
      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3

    end

    it "商品可以放到購物車裡，也可以再拿出該商品。" do 
      cart = Cart.new 

      # v1 = Vendor.create(title: 'zoo')
      # p1 = Product.create(name: 'rhino', list_price: 10, sell_price: 5, vendor: v1)
      p1 = FactoryBot.create(:product)

      cart.add_item(p1.id)

      expect(cart.items.first.product).to be_a Product

    end

  end

  describe "進階功能" do 
  end
end
