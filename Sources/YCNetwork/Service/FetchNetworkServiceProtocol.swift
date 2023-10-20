//
//  FetchNetworkServiceProtocol.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public protocol FetchNetworkServiceProtocol {
    
    func perform(_ request: FetchNetworkRequest) async throws
    func perform<T: Decodable>(_ request: FetchNetworkRequest) async throws -> T
    
}
