require('pry-byebug')
require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')
require_relative('db/sql_runner')

Star.delete_all
Movie.delete_all

star1 = Star.new({
  'first_name' => 'Amy',
  'last_name' => 'Foob'
  })

  star1.save()

  movie1 = Movie.new({
    'title' => 'The Foob Sisters',
    'genre' => 'comedy',
    'budget' => '50000000'
    })

    movie1.save()

  binding.pry

  nil
