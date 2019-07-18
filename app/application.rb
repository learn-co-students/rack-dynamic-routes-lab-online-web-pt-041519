require_relative "../config/environment"

class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # binding.pry

    if req.path.include?("/items/")
      requested_item = req.path.split("/items/").last
      found_item = Item.items.find {|i| i.name == requested_item }
      # binding.pry
      if !found_item.nil?
        resp.write "#{found_item.price}"
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
