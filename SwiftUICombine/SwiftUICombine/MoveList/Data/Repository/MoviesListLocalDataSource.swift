//
//  MoviesListLocalDataSource.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 29/11/2024.
//

import Foundation
protocol MoviesListLocalDataSourceContract {
    func getCachedMovies(for genreId: Int?, page: Int) -> MoviesResponse?
    func cacheMovies(_ movies: MoviesResponse, for genreId: Int?, page: Int)
    
    func getCachedGenres() -> GenreResponse?
    func cacheGenres(_ genres: GenreResponse)
}

final class MoviesListLocalDataSource: MoviesListLocalDataSourceContract {
    private let moviesCacheKeyPrefix = "cachedMovies_"
    private let genresCacheKey = "cachedGenres"
    
    func getCachedMovies(for genreId: Int?, page: Int) -> MoviesResponse? {
        guard let genreId = genreId else { return nil }
        let cacheKey = "\(moviesCacheKeyPrefix)\(genreId)_\(page)"
        
        if let data = UserDefaults.standard.data(forKey: cacheKey),
           let cachedResponse = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
            return cachedResponse
        }
        return nil
    }
    
    func cacheMovies(_ movies: MoviesResponse, for genreId: Int?, page: Int) {
        guard let genreId = genreId else { return }
        let cacheKey = "\(moviesCacheKeyPrefix)\(genreId)_\(page)"
        
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }
    
    func getCachedGenres() -> GenreResponse? {
        if let data = UserDefaults.standard.data(forKey: genresCacheKey),
           let cachedGenres = try? JSONDecoder().decode(GenreResponse.self, from: data) {
            return cachedGenres
        }
        return nil
    }
    
    func cacheGenres(_ genres: GenreResponse) {
        if let data = try? JSONEncoder().encode(genres) {
            UserDefaults.standard.set(data, forKey: genresCacheKey)
        }
    }
}
