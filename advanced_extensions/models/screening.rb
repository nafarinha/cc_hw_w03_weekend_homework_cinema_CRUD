require_relative("../db/sql_runner")

class Screening
  attr_reader :id
  attr_accessor :showtime, :film_id

  def initialize( options )
    @id = options['id'] if options['id']
    @showtime = options['showtime']
    @film_id = options['film_id']
  end

=begin
- ONE screening can have MANY tickets
- Two different screenings can share the same showtime value
- A screening can only have ONE film
- Added film_id because a screening may not sell any tickets, but still needs a reference to the film
=end

  def save()
    sql = "INSERT INTO screenings
      (showtime, film_id)
      VALUES ($1, $2)
      RETURNING id"
    values = [@showtime, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
      SET showtime = $1, film_id = $2
      WHERE id = $3"
    values = [@showtime, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  #Class methods

    def self.all()
      sql = "SELECT * FROM screenings"
      screenings = SqlRunner.run(sql)
      result = screenings.map{ |screening| Screening.new(screening) }
      return result
    end

    def self.delete_all()
      sql = "DELETE FROM screenings"
      SqlRunner.run(sql)
    end

#END OF CLASS
end
