require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize ( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def customers()
    sql = "SELECT * FROM films f
      INNER JOIN tickets t
        ON t.film_id = f.id
      INNER JOIN customers c
        ON c.id = t.customer_id
      WHERE f.id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def save()
  sql = "INSERT INTO films
    (title, price)
    VALUES ($1, $2)
    RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run(sql, values).first
  @id = film['id'].to_i
end

  def update()
    sql = "UPDATE films
      SET title = $1, price = $2
      WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


#Class methods

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map{ |film| Film.new(film) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end
#end of class
end
