require("pry-byebug")
require_relative("./models/customer")
require_relative("./models/film")
require_relative("./models/ticket")

customer_1 = Customer.new({"name" => "Kashif Mcfarlane", "funds" => 20})
customer_2 = Customer.new({"name" => "Helena Prentice", "funds" => 5})
customer_3 = Customer.new({"name" => "Lexi Odling", "funds" => 10})
customer_4 = Customer.new({"name" => "Hilda Alston", "funds" => 15})

customer_1.save()
customer_2.save()
customer_3.save()
customer_4.save()

film_1 = Film.new({"title" => "Matrix", "price" => 3.50})
film_2 = Film.new({"title" => "Avengers: Endgame - 3D", "price" => 11.00})
film_3 = Film.new({"title" => "Captain Marvel", "price" => 9.50})
film_4 = Film.new({"title" => "Interstellar", "price" => 5.00})

ticket_1 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_1.id })
ticket_2 = Ticket.new({ "customer_id" => customer_2.id, "film_id" => film_1.id })
ticket_3 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_2.id })
ticket_4 = Ticket.new({ "customer_id" => customer_3.id, "film_id" => film_3.id })

binding.pry
nil
