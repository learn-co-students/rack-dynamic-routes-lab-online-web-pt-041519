class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.include?("/items/")
            item = req.path.split("/items/").last
            find_item = Item.items.find {|i| i.name == item}
                if !find_item.nil?
                resp.write "#{find_item.price}"
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