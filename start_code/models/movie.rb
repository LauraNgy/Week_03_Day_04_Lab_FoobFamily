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

      # def movies()
      #   sql = "
      #     SELECT * FROM
      #       movies
      #       WHERE
      #       id = $1
      #     "
      #   values = [@artistID]
      #   result = SqlRunner.run(sql, values)
      #   return result.map { |param| Artist.new(param) }[0]
      # end

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
