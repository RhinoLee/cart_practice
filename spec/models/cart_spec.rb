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

  end

  describe "進階功能" do 
  end
end
