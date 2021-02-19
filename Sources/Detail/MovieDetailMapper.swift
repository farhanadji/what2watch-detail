//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Core

public struct MovieDetailMapper: Mapper {
    
    public init() {}
    
    public typealias Response = MovieDetailResponse
    
    public typealias Request = Bool
    
    public typealias Entity = MovieEntity
    
    public typealias Domain = MovieDetail
    
    public func transformResponsesToDomains(response: MovieDetailResponse) -> MovieDetail {
        return MovieDetail(
            id: response.id ?? 0,
            posterPath: response.posterPath ?? "",
            backdropPath: response.backdropPath ?? "",
            title: response.title ?? "-",
            overview: response.overview ?? "-",
            releaseDate: response.releaseDate ?? "-",
            genres: response.genresString,
            status: response.status ?? "-",
            voteAverage: response.voteAverage ?? 0,
            voteCount: response.vouteCount ?? 0,
            popularity: response.popularity ?? 0
            )
    }
    
    public func transformEntitiesToDomains(entity: MovieEntity) -> MovieDetail {
        fatalError()
    }
    
    public func transformDomainToEntity(domain movieDomain: MovieDetail) -> MovieEntity {
        let movie = MovieEntity()
        movie.id = movieDomain.id
        movie.backdropPath = movieDomain.backdropPath
        movie.posterPath = movieDomain.posterPath
        movie.releaseDate = movieDomain.releaseDate
        movie.title = movieDomain.title
        
        return movie
    }
    
}
