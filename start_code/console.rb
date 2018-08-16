require('pry-byebug')
require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')
require_relative('db/sql_runner')

Star.delete_all

star1 = Star.new({
  'first_name' => 'Amy',
  'last_name' => 'Foob'
  })

  star1.save()

  binding.pry

  nil
