class LinepayService

  def initialize(api_step)
    @api_step = api_step
  end

  def perform(body)

    resp = Faraday.post("#{ENV['line_pay_endpoint']}/v2/#{@api_step}") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-LINE-ChannelId'] = ENV['line_pay_channel_id']
      req.headers['X-LINE-ChannelSecret'] = ENV['line_pay_channel_secret']
      req.body = body.to_json 
      
    end

    @result = JSON.parse(resp.body) 
  end

  def is_success? 
    @result["returnCode"] == "0000"
  end

  def payment_url 
    @result["info"]["paymentUrl"]["web"]
  end

  def order_id 
    @result["info"]["orderId"]
  end

  def transaction_id 
    @result["info"]["transactionId"]
  end

end

