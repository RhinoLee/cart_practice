class Cart 
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def self.from_hash(hash = nil)

    if hash && hash["items"]
      items = hash["items"].map { |item| CartItem.new(item["product_id"], item["quantity"] ) }

      Cart.new(items)
    else
      Cart.new
    end

  end

  def serialize

    items = @items.map { |item| { "product_id" => item.product_id, "quantity" => item.quantity } }

    { "items" => items }

  end

  def add_item(product_id)
    found = @items.find { |item| item.product_id == product_id }

    if found
      found.increment!
    else 
      @items << CartItem.new(product_id)
    end

  end

  def cart_total_price 
    @items.reduce(0) { |sum, item| sum + item.total_price }
  end

  def christmas(total_price)
    
    Timecop.freeze(Time.zone.local(2000,12,25)) do
      currentMonth = Time.now.month
      currentDay = Time.now.day

      if currentMonth == 12 && currentDay == 25 
        total_price.to_i - 100
      end
    end
    
  end

  def empty? 
    @items.empty?
  end

end