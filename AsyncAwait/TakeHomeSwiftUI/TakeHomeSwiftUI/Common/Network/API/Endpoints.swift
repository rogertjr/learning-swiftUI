//
//  Endpoints.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 22/08/22.
//

import Foundation

enum Endpoint {
    case people(_ page: Int)
    case detail(_ id: Int)
    case create(_ data: Data?)
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(_ data: Data?)
    }
}

extension Endpoint {
    var base: String { "reqres.in" }
    var api: String { "/api" }
    
    var path: String {
        switch self {
        case .people,
                .create:
            return "\(api)/users"
        case .detail(let id):
            return "\(api)/users/\(id)"
        }
    }
    
    var method: MethodType {
        switch self {
        case .people,
                .detail:
            return .GET
        case .create(let data):
            return .POST(data)
            
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .people(let page):
            return ["page": "\(page)"]
        default:
            return nil
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = base
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        queryItems?.forEach({ item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        })
        
        #if DEBUG
        requestQueryItems.append(URLQueryItem(name: "delay", value: "2"))
        #endif
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
