//
//  TVMapper.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import CatalogCommon

public final class HomeTVMapper {
    public init() {}
    public static func mapResponseToEntities(response: [TVPopularResponseResult]?) -> [TVListEntity] {
        guard let response = response else {return []}
        return response.map{ res in
            let entity = TVListEntity()
            entity.id = res.id
            entity.title = res.name ?? ""
            entity.posterImage = API.imgBaseUrl + (res.posterPath ?? "")
            entity.desc = res.overview ?? ""
            entity.firstAiring = res.firstAirDate ?? ""
            return entity
        }
    }
    
    public static func mapEntityToDomain(entities: [TVListEntity]) -> [TVListModel] {
        return entities.map{res in
            let model = TVListModel(id: res.id, title: res.title, posterImage:  res.posterImage, desc: res.desc, firstAiring: res.firstAiring, isFavorite: res.isFavorite)
            return model
        }
    }
    
    public static func mapResponseToDomain(response: TVPopularResponse) -> [TVListModel] {
        guard let result = response.results else {return []}
        return result.map{ res in
            let entity = TVListModel(
                id: res.id,
                title: res.name ?? "",
                posterImage: API.imgBaseUrl + (res.posterPath ?? ""),
                desc: res.overview ?? "",
                firstAiring: res.firstAirDate ?? "",
                isFavorite: false
            )
            return entity
        }
    }
}
