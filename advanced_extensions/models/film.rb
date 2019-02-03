require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize ( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

#EXTENSIONS
  def total_customers()
    self.customers.size()
  end

  def most_popular_showtime()
    sql = "SELECT s.* FROM screenings s
      INNER JOIN tickets t
        ON t.screening_id = s.id
      INNER JOIN films f
        ON f.id = t.film_id
      WHERE f.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    screening_times = result.map { |screening| screening["showtime"] }
=begin
The following code works but if two screenings are equally popular it just returns the first one and disregards the others that are as popular:
    most_popular = screening_times.max_by { |showtime| screening_times.count(showtime) }
    return most_popular
=end

    most_popular = []

    count_screenings = screening_times.uniq.map{ |showtime| [showtime,screening_times.count(showtime)] }.to_h

    count_screenings.each {  |k, v| most_popular << k if v == count_screenings.values.max }
    return most_popular
=begin
    # source: https://stackoverflow.com/a/30688107/5621295
    array.max_by { |i| array.count(i) }

    # source: https://stackoverflow.com/a/43232979/5621295
    things = [1, 2, 2, 3, 3, 3, 4]
    things.uniq.map{|t| [t,things.count(t)]}.to_h

    # source: https://stackoverflow.com/a/17323406/5621295
    hash.each { |k, v| puts k if v == hash.values.max }
=end
  end

#END EXTENSIONS


  def customers()
    sql = "SELECT c.* FROM customers c
      INNER JOIN tickets t
        ON t.customer_id = c.id
      INNER JOIN films f
        ON f.id = t.film_id
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
