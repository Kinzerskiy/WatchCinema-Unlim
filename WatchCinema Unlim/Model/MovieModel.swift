//
//  MovieModel.swift
//  WatchCinema Unlim
//
//  Created by User on 13.05.2024.
//

import Foundation

// MARK: - MovieList

struct Movie: Codable {
   
    var releaseDate: String?
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let popularity: Double
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct MovieListResponse: Codable {
    let dates: Dates?
    let page: Int
    let results: [Movie]
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}

// MARK: - MovieDetails

struct MovieDetails: Codable {
    var firstAirDate: String?
    var genres: [Genre]
    var releaseDate: String?
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int
    let homepage: String
    let id: Int
    let imdbId: String
    let originCountry: [String]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
   
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
}

 struct Genre: Codable {
    let id: Int
    let name: String
}

 struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

 struct ProductionCountry: Codable {
    let iso31661: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

//MARK: Similar

struct SimilarMoviesResponse: Codable {
    let page: Int
    let results: [SimilarMovie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SimilarMovie: Codable {
   
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let popularity: Double?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//MARK: Search

struct SearchMovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//MARK: GenreID

enum MovieGenreID: String, CaseIterable {
    case action = "28"
    case adventure = "12"
    case animation = "16"
    case comedy = "35"
    case crime = "80"
    case documentary = "99"
    case drama = "18"
    case family = "10751"
    case fantasy = "14"
    case history = "36"
    case horror = "27"
    case music = "10402"
    case mystery = "9648"
    case romance = "10749"
    case scienceFiction = "878"
    case tvMovie = "10770"
    case thriller = "53"
    case war = "10752"
    case western = "37"
    
    static var allCases: [MovieGenreID] {
        return [.action, .adventure, .animation, .comedy, .crime, .documentary, .drama, .family, .fantasy, .history, .horror, .music, .mystery, .romance, .scienceFiction, .tvMovie, .thriller, .war, .western]
    }
}

// MARK: - MovieVideosResponse
struct MovieVideosResponse: Codable {
    let id: Int
    let results: [MovieVideos]
}

// MARK: - Result
struct MovieVideos: Codable {
    let iso639_1: ISO639_1
    let iso3166_1: ISO3166_1
    let name, key: String
    let site: Site
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum ISO3166_1: String, Codable {
    case us = "US"
}

enum ISO639_1: String, Codable {
    case en = "en"
}

enum Site: String, Codable {
    case youTube = "YouTube"
}


// MARK: - MovieCreditsResponse
struct MovieCreditsResponse: Codable {
    let id: Int
    let cast, crew: [MovieCast]
}

// MARK: - Cast
struct MovieCast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
