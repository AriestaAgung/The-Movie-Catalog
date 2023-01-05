//
//  MovieMapper.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation

final class HomeMovieMapper {
    static func mapResponseToEntities(response: [MoviePopularResponseResult]?) -> [MovieListEntity] {
        guard let response = response else {return []}
        return response.map{ res in
            let entity = MovieListEntity()
            entity.id = res.id.description
            entity.title = res.title ?? ""
            entity.posterImage = API.imgBaseUrl + (res.posterPath ?? "")
            entity.desc = res.overview ?? ""
            entity.firstAiring = res.releaseDate ?? ""
            return entity
        }
    }
    
    static func mapEntityToDomain(entities: [MovieListEntity]) -> [MovieListModel] {
        return entities.map{res in
            let model = MovieListModel(id: res.id, title: res.title, posterImage:  res.posterImage, desc: res.desc, firstAiring: res.firstAiring)
            return model
        }
    }
    
    static func mapResponseToDomain(response: MoviePopularResponse) -> [MovieListModel] {
        guard let result = response.results else {return []}
        return result.map{ res in
            let entity = MovieListModel(
                id: res.id.description,
                title: res.title ?? "",
                posterImage: API.imgBaseUrl + (res.posterPath ?? ""),
                desc: res.overview ?? "",
                firstAiring: res.releaseDate ?? ""
            )
            return entity
        }
    }
}