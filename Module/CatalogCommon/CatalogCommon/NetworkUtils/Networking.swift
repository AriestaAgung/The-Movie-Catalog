//
//  Networking.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import Foundation

public struct API {
    public init() {}
    
    public static let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
    public static let imgBaseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseImageURL") as! String
    public static let apiKey = Bundle.main.object(forInfoDictionaryKey: "MovieAPIKey") as! String
}

protocol Endpoint {
    var url: String { get }
}

public enum Endpoints {
    
    public enum Gets: Endpoint {
        case movieList
        case movieDetail
        case tvList
        case tvDetail
        
        public var url: String {
            switch self {
            case .movieList: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
            case .movieDetail: return "\(API.baseUrl)movie/"
            case .tvList: return "\(API.baseUrl)tv/popular?api_key=\(API.apiKey)"
            case .tvDetail: return "\(API.baseUrl)tv/"
            }
        }
    }
    
}

