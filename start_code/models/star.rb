class Star

  attr_reader :id
  attr_accessor :first_name, :last_name, :age

    def initialize(options)
      @first_name = options['first_name']
      @last_name = options['last_name']
      @age = options['age'].to_i
      @id = options['id'].to_i if options['id']
    end

    def save()
      sql = "
        INSERT INTO stars
        (first_name, last_name, age)
        VALUES
        ($1, $2, $3)
        RETURNING *
      "
      values = [@first_name, @last_name, @age]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = "
        UPDATE
          stars
        SET
          (first_name, last_name, age) = ($1, $2, $3)
        WHERE
          id = $4
        "
      values = [@first_name, @last_name, @age, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "
        DELETE FROM
          stars
        WHERE
          id = $1
        "
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def movies()
      sql = "
        SELECT
          movies.*
        FROM
          movies
        INNER JOIN
          castings
        ON
          castings.movie_id = movies.id
        WHERE
          castings.star_id = $1
        "
      values = [@id]
      movies = SqlRunner.run(sql, values)
      return Movie.map_items(movies)
    end

    def Star.all()
      sql = "SELECT * FROM stars"
      stars = SqlRunner.run(sql)
      return self.map_items(stars)
    end

    def self.map_items(star_data)
      result = star_data.map { |star| Star.new(star) }
      return result
    end

    def Star.delete_all()
      sql = "DELETE FROM stars"
      SqlRunner.run(sql)
    end




end
