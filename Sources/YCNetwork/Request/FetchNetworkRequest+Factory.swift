//
//  FetchNetworkRequest+Factory.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public extension FetchNetworkRequest {
    
    static func get(
        URLPath: String,
        URLParams: [String: String] = [:],
        interceptors: [RequestInterceptor] = []
    ) -> Self {
        self.init(method: .get,
                  URLPath: URLPath,
                  URLParams: URLParams,
                  body: nil,
                  interceptors: interceptors)
    }
    
    static func post(
        URLPath: String,
        body: Encodable? = nil,
        interceptors: [RequestInterceptor] = []
    ) -> Self {
        self.init(method: .post,
                  URLPath: URLPath,
                  URLParams: [:],
                  body: body,
                  interceptors: interceptors)
    }
    
    static func patch(
        URLPath: String,
        body: Encodable? = nil,
        interceptors: [RequestInterceptor] = []
    ) -> Self {
        self.init(method: .patch,
                  URLPath: URLPath,
                  URLParams: [:],
                  body: body,
                  interceptors: interceptors)
    }
    
    static func delete(
        URLPath: String,
        interceptors: [RequestInterceptor]
    ) -> Self {
        self.init(method: .delete,
                  URLPath: URLPath,
                  URLParams: [:],
                  body: nil,
                  interceptors: interceptors)
    }
    
}
