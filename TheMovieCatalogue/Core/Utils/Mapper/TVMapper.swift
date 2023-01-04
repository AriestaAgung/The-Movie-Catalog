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
            entity.id = String(describing: res.id)
            entity.title = res.name ?? ""
            entity.posterImage = res.posterPath ?? ""
            entity.desc = res.overview ?? ""
            return entity
        }
    }
    
    static func mapEntityToDomain(entities: [TVEntity]) -> [TVListModel] {
        return entities.map{res in
            let model = TVListModel(id: res.id, title: res.title, posterImage: res.posterImage, desc: res.desc)
            return model
        }
    }
    
    static func mapResponseToDomain(response: TVPopularResponse) -> [TVListModel] {
        guard let result = response.results else {return []}
        return result.map{ res in
            let entity = TVListModel(
                id: String(describing: res.id),
                title: res.name ?? "",
                posterImage: res.posterPath ?? "",
                desc: res.overview ?? ""
            )
            return entity
        }
    }
}
