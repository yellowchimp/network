//
//  AuthorizationInterceptor.swift
//  
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public struct AuthorizationInterceptor: RequestInterceptor {
    
    private let value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public func intercept(_ request: inout URLRequest) async throws {
        request.addValue(value, forHTTPHeaderField: "Authorization")
    }
    
}

public extension AuthorizationInterceptor {
    
    static func basic(value: String) -> Self {
        .init(value: "Basic \(value)")
    }
    
    static func bearer(value: String) -> Self {
        .init(value: "Bearer \(value)")
    }
    
}
