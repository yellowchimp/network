//
//  FetchNetworkRequest.swift
//  
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public struct FetchNetworkRequest {
    
    private let method: HTTPMethod
    private let URLPath: String
    private let URLParams: [String: String]
    private let body: Encodable?
    private let interceptors: [RequestInterceptor]
    
    public init(
        method: HTTPMethod,
        URLPath: String,
        URLParams: [String : String],
        body: Encodable?,
        interceptors: [RequestInterceptor]
    ) {
        self.method = method
        self.URLPath = URLPath
        self.URLParams = URLParams
        self.body = body
        self.interceptors = interceptors
    }
        
    func urlRequest(baseURL: String,
                    encoder: JSONEncoder? = nil,
                    defaultRequestInterceptors: [RequestInterceptor]) throws -> URLRequest {
        
        guard var url = URL(string: baseURL) else {
            throw FetchNetworkError.malformedURL
        }
        
        url.appendPathComponent(URLPath)
        
        if !URLParams.isEmpty {
            url = url.appendingQueryParameters(URLParams)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        try defaultRequestInterceptors.forEach { interceptor in
            try interceptor.intercept(&urlRequest)
        }
        
        try interceptors.forEach { interceptor in
            try interceptor.intercept(&urlRequest)
        }
        
        if method != .get,
           let body = body,
           let encoder = encoder {
            urlRequest.httpBody = try encoder.encode(body)
        }
        
        return urlRequest
    }
    
}
