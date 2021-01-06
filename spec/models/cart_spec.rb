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

      p1 = create(:product)

      cart.add_item(p1.id)

      expect(cart.items.first.product).to be_a Product

    end

    it "可以計算整台購物車的總消費金額" do 
      cart = Cart.new 

      p1 = create(:product, sell_price: 5)
      p2 = create(:product, sell_price: 10)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.cart_total_price).to eq(35)

    end

    it "聖誕節折扣，滿千送百" do 
      cart = Cart.new 

      p1 = create(:product, sell_price: 1000)
      p2 = create(:product, sell_price: 1000)

      cart.add_item(p1.id)
      cart.add_item(p2.id)
      
      expect(cart.christmas(cart.cart_total_price)).to eq(1900)
    end

    

  end

  describe "進階功能" do 
  end
end
