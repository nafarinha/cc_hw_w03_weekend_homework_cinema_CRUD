require("pry-byebug")
require_relative("./models/customer")
require_relative("./models/film")
require_relative("./models/ticket")
require_relative("./models/screening")

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

customer_1 = Customer.new({"name" => "Kashif Mcfarlane", "funds" => 20})
customer_2 = Customer.new({"name" => "Helena Prentice", "funds" => 10})
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
film_5 = Film.new({"title" => "Akira", "price" => 5.00})

film_1.save()
film_2.save()
film_3.save()
film_4.save()
film_5.save()



#film_1 screenings
screening_1 = Screening.new({ "showtime" => "14:30"})
screening_2 = Screening.new({ "showtime" => "17:00"})
screening_3 = Screening.new({ "showtime" => "19:10"})
screening_4 = Screening.new({ "showtime" => "21:45"})

screening_1.save()
screening_2.save()
screening_3.save()
screening_4.save()

screening_1.showtime = "14:45"
screening_1.update()

ticket_1 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_1.id, "screening_id" => screening_1.id })
ticket_2 = Ticket.new({ "customer_id" => customer_2.id, "film_id" => film_1.id, "screening_id" => screening_1.id })
ticket_3 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_2.id, "screening_id" => screening_2.id })
ticket_4 = Ticket.new({ "customer_id" => customer_3.id, "film_id" => film_3.id, "screening_id" => screening_3.id })
ticket_5 = Ticket.new({ "customer_id" => customer_3.id, "film_id" => film_5.id, "screening_id" => screening_4.id })

ticket_6 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_1.id, "screening_id" => screening_4.id })

#test most_popular_showtime
ticket_7 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_1.id, "screening_id" => screening_4.id })
ticket_8 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_1.id, "screening_id" => screening_4.id })
ticket_9 = Ticket.new({ "customer_id" => customer_1.id, "film_id" => film_1.id, "screening_id" => screening_4.id })



ticket_1.save()
ticket_2.save()
ticket_3.save()
ticket_4.save()
ticket_5.save()
ticket_6.save()

ticket_7.save()
ticket_8.save()
ticket_9.save()


# customer_1.funds = 25
# customer_2.name = "Helen Prentice"
# customer_1.update()
# customer_2.update()

# film_1.price = 3.00
# film_4.title = "Interstellar - Director's Cut"
# film_1.update()
# film_4.update()

# ticket_5.customer_id = customer_4.id
# ticket_5.film_id = film_4.id
# ticket_5.update()

# Customer.all()
# Film.all()
# Ticket.all()

# customer_1.films()
# film_1.customers()


customer_1.total_tickets()
customer_4.buy_ticket(film_1, screening_1)

film_1.total_customers()

film_1.most_popular_showtime()

binding.pry
nil
