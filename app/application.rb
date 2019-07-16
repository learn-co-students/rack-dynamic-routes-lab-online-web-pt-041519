require 'pry'
class Application
    @@items = Item.items

    @@names = []


    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        @@items.each do |item|
            @@names << item.name
        end   

        if req.path.match(/items/)
            input = req.path.gsub(/\/[a-zA-Z]+\W/,"")
            req.params["item"]= input
            #binding.pry
            if @@names.include?(req.params["item"])
                @@items.each do |item|
                    #binding.pry
                    if item.name == input 
                        resp.write "#{item.price}" 
                        resp.status = 200
                        #binding.pry
                    end
                end        
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