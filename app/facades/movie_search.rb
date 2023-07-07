class MovieSearch
  def service
    MovieService.connect
  end

  def get_url(url)
    connection = service
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def keyword_search(keyword)
    movies = get_url("/3/search/movie?query=#{keyword}&include_adult=false&page=1")
    movie_objects = movies[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def discover_popular
    get_url("/3/discover/movie?include_adult=false&page=1&sort_by=popularity.desc")
    movie_objects = movies[:results].map do |movie|
      Movie.new(movie)
    end
  end
end