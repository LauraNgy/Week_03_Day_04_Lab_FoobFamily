class Casting

    attr_reader :id
    attr_accessor :movie_id, :star_id, :fee

      def initialize(options)
        @movie_id = options['movie_id'].to_i
        @star_id = options['star_id'].to_i
        @fee = options['fee'].to_i
        @id = options['id'].to_i if options['id']
      end

      def save()
        sql = "
          INSERT INTO castings
          (movie_id, star_id, fee)
          VALUES
          ($1, $2, $3)
          RETURNING *
        "
        values = [@movie_id, @star_id, @fee]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
      end

      def update()
        sql = "
          UPDATE
            castings
          SET
            (movie_id, star_id, fee) = ($1, $2, $3)
          WHERE
            id = $4
          "
        values = [@movie_id, @star_id, @fee, @id]
        SqlRunner.run(sql, values)
      end

      def delete()
        sql = "
          DELETE FROM
            castings
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

      def Casting.all()
        sql = "SELECT * FROM castings"
        castings = SqlRunner.run(sql)
        return self.map_items(castings)
      end

      def self.map_items(casting_data)
        result = casting_data.map { |casting| Casting.new(casting) }
        return result
      end

      def Casting.delete_all()
        sql = "DELETE FROM castings"
        SqlRunner.run(sql)
      end


end
