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
    movies[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def discover_popular
    movies = get_url('/3/discover/movie?include_adult=false&page=1&sort_by=popularity.desc')
    movies[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def full_movie_details_by_id(id)
    movie_data = get_url("/3/movie/#{id}?append_to_response=credits,reviews,images")
    Movie.new(movie_data)
  end

  def movie_image(id)
    conn = MovieService.connect_no_key

    movie_data = get_url("/3/movie/#{id}?append_to_response=credits,reviews,images")
    poster_path = movie_data[:images][:posters].first[:file_path]
    response = conn.get("https://image.tmdb.org/t/p/w300#{poster_path}.jpg")
  end
end
