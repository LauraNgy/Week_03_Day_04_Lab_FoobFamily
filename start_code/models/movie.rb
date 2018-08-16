class Movie

    attr_reader :id
    attr_accessor :title, :genre, :budget

      def initialize(options)
        @title = options['title']
        @genre = options['genre']
        @budget = options['budget']
        @id = options['id'].to_i if options['id']
      end

      def save()
        sql = "
          INSERT INTO stars
          (title, genre)
          VALUES
          ($1, $2)
          RETURNING *
        "
        values = [@title, @genre]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
      end

      def update()
        sql = "
          UPDATE
            stars
          SET
            (title, genre) = ($1, $2)
          WHERE
            id = $3
          "
        values = [@title, @genre, @id]
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

      # def movies()
      #   sql = "
      #     SELECT * FROM
      #       stars
      #       WHERE
      #       id = $1
      #     "
      #   values = [@artistID]
      #   result = SqlRunner.run(sql, values)
      #   return result.map { |param| Artist.new(param) }[0]
      # end

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
