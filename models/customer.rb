require_relative("../db/sql_runner")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

#EXTENSIONS
  def buy_ticket(film)
    price = film.price()
    return if price >= @funds
    @funds -= price
    self.update()
    new_ticket = Ticket.new({"customer_id" => @id, "film_id" => film.id})
    new_ticket.save()
  end

  def total_tickets()
    sql = "SELECT t.* FROM tickets t
      INNER JOIN customers c
        ON c.id = t.customer_id
      WHERE c.id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    total_tickets = tickets.map { |ticket| Ticket.new(ticket) }
    return total_tickets.size()
  end

#END_EXTENSIONS


  def films()
    sql = "SELECT f.* FROM films f
      INNER JOIN tickets t
        ON t.film_id = f.id
      INNER JOIN customers c
        ON c.id = t.customer_id
      WHERE c.id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map{ |film| Film.new(film) }
    return result
  end

  def save()
  sql = "INSERT INTO customers
    (name, funds)
    VALUES ($1, $2)
    RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

  def update()
    sql = "UPDATE customers
      SET name = $1, funds = $2
      WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

#Class methods
  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map{ |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end


#end of class
end
