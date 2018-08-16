class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

    def initialize(options)
      @first_name = options['first_name']
      @last_name = options['last_name']
      @id = options['id'].to_i if options['id']
    end

    def save()
      sql = "
        INSERT INTO stars
        (first_name, last_name)
        VALUES
        ($1, $2)
        RETURNING *
      "
      values = [@first_name, @last_name]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = "
        UPDATE
          stars
        SET
          (first_name, last_name) = ($1, $2)
        WHERE
          id = $3
        "
      values = [@first_name, @last_name, @id]
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
