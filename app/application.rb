class Application

  #@@items = [Item.new("MacBook",2000.00)]
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #Returns item price if it is in @@item
    if req.path.match(/items/)
      itemname = req.path.split("/items/").last
      if item =@@items.find{|i| i.name == itemname}
        resp.write item.price
        #binding.pry
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status=404
      resp.write "Route not found"
    end
    resp.finish
  end

end
