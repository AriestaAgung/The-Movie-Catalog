//
//  TVMapper.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation

final class HomeTVMapper {
    static func mapResponseToEntities(response: [TVPopularResponseResult]?) -> [TVEntity] {
        guard let response = response else {return []}
        return response.map{ res in
            let entity = TVEntity()
            entity.id = res.id.description
            entity.title = res.name ?? ""
            entity.posterImage = API.imgBaseUrl + (res.posterPath ?? "")
            entity.desc = res.overview ?? ""
            entity.firstAiring = res.firstAirDate ?? ""
            return entity
        }
    }
    
    static func mapEntityToDomain(entities: [TVEntity]) -> [TVListModel] {
        return entities.map{res in
            let model = TVListModel(id: res.id, title: res.title, posterImage:  res.posterImage, desc: res.desc, firstAiring: res.firstAiring)
            return model
        }
    }
    
    static func mapResponseToDomain(response: TVPopularResponse) -> [TVListModel] {
        guard let result = response.results else {return []}
        return result.map{ res in
            let entity = TVListModel(
                id: res.id.description,
                title: res.name ?? "",
                posterImage: API.imgBaseUrl + (res.posterPath ?? ""),
                desc: res.overview ?? "",
                firstAiring: res.firstAirDate ?? ""
            )
            return entity
        }
    }
}
