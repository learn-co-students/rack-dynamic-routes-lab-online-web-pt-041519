class Application
  @@items = []
  # @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # If URL includes /items/, look for additional input. Else return 404 and error message.
    if req.path.match(/items/)
    
      # Get final parameter, transform it into string
      item_param = req.path.match(/(?<=\/items\/)(\w+)/).to_s

      # Find parameter in array
      i = @@items.find { |obj| obj.name.downcase == item_param.downcase }

      # If item exists, return price. Else return 400 and error message.
      if i
        resp.write "#{i.price}"
      else 
        resp.write "Item not found"
        resp.status = 400
      end
    else 
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
