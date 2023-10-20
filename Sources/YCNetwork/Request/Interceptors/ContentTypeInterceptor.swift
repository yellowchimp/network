//
//  ContentTypeInterceptor.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public struct ContentTypeInterceptor: RequestInterceptor {
    
    private let value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public func intercept(_ request: inout URLRequest) throws {
        request.addValue(value, forHTTPHeaderField: "Content-Type")
    }
    
}

public extension ContentTypeInterceptor {
    
    static func json() -> Self {
        .init(value: "application/json; charset=utf-8")
    }
    
}
