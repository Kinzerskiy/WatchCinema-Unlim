//
//  ApiManager.swift
//  WatchCinema Unlim
//
//  Created by User on 12.05.2024.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    let apiKey = "cda51d812f56853ddcc3009f57b4fdb3"
  
    //MARK: Movies
    
    func fetchNowPlayingMovies(page: Int, completion: @escaping ([Movie], Error?) -> Void) {
        fetchMovies(with: "https://api.themoviedb.org/3/movie/now_playing", page: page, completion: completion)
    }
    
    func fetchPopularMovies(page: Int, completion: @escaping ([Movie], Error?) -> Void) {
        fetchMovies(with: "https://api.themoviedb.org/3/movie/popular", page: page, completion: completion)
    }
    
    func fetchTopRatedMovies(page: Int, completion: @escaping ([Movie], Error?) -> Void) {
        fetchMovies(with: "https://api.themoviedb.org/3/movie/top_rated", page: page, completion: completion)
    }
    
    func fetchUpcomingMovies(page: Int, completion: @escaping ([Movie], Error?) -> Void) {
        fetchMovies(with: "https://api.themoviedb.org/3/movie/upcoming", page: page, completion: completion)
    }
    
    private func fetchMovies(with urlString: String, page: Int, completion: @escaping ([Movie], Error?) -> Void) {
        fetchData(urlString: urlString, page: page) { (response: MovieListResponse?, error) in
            guard let response = response else {
                completion([], error)
                return
            }
            
            let movies = response.results
            completion(movies, nil)
        }
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (MovieDetails?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)"
        fetchData(urlString: urlString, completion: completion)
    }
   
    func fetchSimilarMovies(movieId: Int, completion: @escaping (SimilarMoviesResponse?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/similar"
        fetchData(urlString: urlString) { (response: SimilarMoviesResponse?, error) in
            if let error = error {
                print("Error fetching similar movies: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            if let response = response {
                completion(response, nil)
            }
        }
    }
    
    func fetchSearchMovies(page: Int, includeAdult: Bool? = nil, primaryReleaseYear: String? = nil, ganre: String? = nil, completion: @escaping ([Movie], Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/discover/movie"
        fetchData(urlString: urlString, includeAdult: includeAdult, primaryReleaseYear: primaryReleaseYear, ganre: ganre, page: page) { (response: SearchMovieResponse?, error) in
            guard let response = response else {
                completion([], error)
                return
            }
            
            let movies = response.results
            completion(movies, nil)
        }
    }
    
    func fetchMovieVideos(movieId: Int, completion: @escaping (MovieVideosResponse?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos"
        fetchData(urlString: urlString) { (response: MovieVideosResponse?, error) in
            if let error = error {
                print("Error fetching movie videos: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            if let response = response {
                completion(response, nil)
            }
        }
    }

    func fetchMovieCredits(movieId: Int, completion: @escaping (MovieCreditsResponse?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits"
        fetchData(urlString: urlString) { (response: MovieCreditsResponse?, error) in
            if let error = error {
                print("Error fetching movie credits: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            if let response = response {
                completion(response, nil)
            }
        }
    }

    //MARK: Common
    
    func fetchData<T: Codable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        fetchData(urlString: urlString, page: nil, completion: completion)
    }
    
    func fetchData<T: Codable>(urlString: String, includeAdult: Bool? = nil, primaryReleaseYear: String? = nil,  firstAirDateYear: String? = nil, ganre: String? = nil, page: Int? = nil, completion: @escaping (T?, Error?) -> Void) {
        if var urlComponents = URLComponents(string: urlString) {
            var queryItems = [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
            if let includeAdult = includeAdult {
                queryItems.append(URLQueryItem(name: "include_adult", value: String(includeAdult)))
            }
            if let primaryReleaseYear = primaryReleaseYear {
                queryItems.append(URLQueryItem(name: "primary_release_year", value: primaryReleaseYear))
            }
            if firstAirDateYear != nil {
                queryItems.append(URLQueryItem(name: "first_air_date_year", value: primaryReleaseYear))
            }
            if let ganre = ganre {
                queryItems.append(URLQueryItem(name: "with_genres", value: ganre))
            }
            if let page = page {
                queryItems.append(URLQueryItem(name: "page", value: String(page)))
            }
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                fatalError("Invalid URL")
            }
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZGE1MWQ4MTJmNTY4NTNkZGNjMzAwOWY1N2I0ZmRiMyIsInN1YiI6IjY2NDBiNTc2MmI1MWE4MjQ4NDIwNzY0YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e9ncYs0iLe3vMCcvqBFO4xOLDqqlIC6VlrAmsrLEhlQ", forHTTPHeaderField: "Authorization")
         
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(response, nil)
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
            task.resume()
        }
    }
}
