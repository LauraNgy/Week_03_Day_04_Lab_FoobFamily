require('pry-byebug')
require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')
require_relative('db/sql_runner')

Star.delete_all
Movie.delete_all
Casting.delete_all

star1 = Star.new({
  'first_name' => 'Amy',
  'last_name' => 'Foob'
  })

star2 = Star.new({
  'first_name' => 'Mindy',
  'last_name' => 'Foob'
  })

star1.save()
star2.save()

movie1 = Movie.new({
  'title' => 'The Foob Sisters',
  'genre' => 'comedy',
  'budget' => '50000000'
  })

  movie1.save()

  movie2 = Movie.new({
    'title' => 'Foob Life',
    'genre' => 'comedy',
    'budget' => '20000000'
    })

    movie2.save()

casting1 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star1.id,
  'fee' => 10000000
  })
casting2 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star2.id,
  'fee' => 10000005
  })

  casting3 = Casting.new({
    'movie_id' => movie2.id,
    'star_id' => star2.id,
    'fee' => 5000005
    })


casting1.save()
casting2.save()
casting3.save()

  binding.pry

  nil
