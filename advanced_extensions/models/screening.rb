require_relative("../db/sql_runner")

class Screening
  attr_reader :id
  attr_accessor :showtime

  def initialize( options )
    @id = options['id'] if options['id']
    @showtime = options['showtime']
  end

  def save()
    sql = "INSERT INTO screenings
      (showtime)
      VALUES ($1)
      RETURNING id"
    values = [@showtime]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
      SET showtime = $1
      WHERE id = $2"
    values = [@showtime, @id]
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
