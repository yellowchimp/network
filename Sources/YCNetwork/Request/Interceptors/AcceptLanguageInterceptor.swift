//
//  AcceptLanguageInterceptor.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public struct AcceptLanguageInterceptor: RequestInterceptor {
    
    private let value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public func intercept(_ request: inout URLRequest) throws {
        request.addValue(value, forHTTPHeaderField: "Accept-Language")
    }
    
}
