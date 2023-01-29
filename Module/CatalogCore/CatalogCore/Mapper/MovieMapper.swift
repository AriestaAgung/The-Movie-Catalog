//
//  MovieMapper.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation
import CatalogCommon

public final class HomeMovieMapper {
    public init() {}
    public static func mapResponseToEntities(response: [MoviePopularResponseResult]?) -> [MovieListEntity] {
        guard let response = response else {return []}
        return response.map{ res in
            let entity = MovieListEntity()
            entity.id = res.id
            entity.title = res.title ?? ""
            entity.posterImage = API.imgBaseUrl + (res.posterPath ?? "")
            entity.desc = res.overview ?? ""
            entity.firstAiring = res.releaseDate ?? ""
            return entity
        }
    }
    
    public static func mapEntityToDomain(entities: [MovieListEntity]) -> [MovieListModel] {
        return entities.map{res in
            let model = MovieListModel(id: res.id, title: res.title, posterImage:  res.posterImage, desc: res.desc, firstAiring: res.firstAiring, isFavorite: res.isFavorite)
            return model
        }
    }
    
    public static func mapResponseToDomain(response: MoviePopularResponse) -> [MovieListModel] {
        guard let result = response.results else {return []}
        return result.map{ res in
            let entity = MovieListModel(
                id: res.id,
                title: res.title ?? "",
                posterImage: API.imgBaseUrl + (res.posterPath ?? ""),
                desc: res.overview ?? "",
                firstAiring: res.releaseDate ?? "",
                isFavorite: false
            )
            return entity
        }
    }
}
