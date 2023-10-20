//
//  FetchNetworkError.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public enum FetchNetworkError: Swift.Error {
    
    case generic
    case malformedURL
    case noHTTPURLResponse
    case unauthorized
    case missingAuthorizationToken
    case reason(String)
}
