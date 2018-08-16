class Movie

  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "
      INSERT INTO movies
      (title, genre, budget)
      VALUES
      ($1, $2, $3)
      RETURNING *
    "
    values = [@title, @genre, @budget]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "
      UPDATE
        movies
      SET
        (title, genre, budget) = ($1, $2, $3)
      WHERE
        id = $4
      "
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "
      DELETE FROM
        movies
      WHERE
        id = $1
      "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def stars()
    sql = "
      SELECT
        stars.*
      FROM
        stars
      INNER JOIN
        castings
      ON
        castings.star_id = stars.id
      WHERE
        castings.movie_id = $1
      "
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return Star.map_items(stars)
  end

  def remaining_budget
    sql = "
      SELECT
        fee
      FROM
        castings
      WHERE
        movie_id = $1
    "
    values = [@id]
    fees = SqlRunner.run(sql, values)
    total_fees = fees.reduce(0){ |total, fee| total + fee['fee'].to_i }
    return @budget - total_fees
  end

  def Movie.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    return self.map_items(movies)
  end

  def self.map_items(movie_data)
    result = movie_data.map { |movie| Movie.new(movie) }
    return result
  end

  def Movie.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end


end
