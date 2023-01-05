//
//  Networking.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import Foundation

struct API {
    static let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
    static let imgBaseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseImageURL") as! String
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "MovieAPIKey") as! String
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case movieList
        case movieDetail
        case tvList
        case tvDetail
        
        public var url: String {
            switch self {
            case .movieList: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
            case .movieDetail: return "\(API.baseUrl)movie/{movie_id}"
            case .tvList: return "\(API.baseUrl)tv/popular?api_key=\(API.apiKey)"
            case .tvDetail: return "\(API.baseUrl)tv/{tv_id}"
            }
        }
    }
    
}

