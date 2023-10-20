//
//  FetchNetworkService.swift
//  
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public final class FetchNetworkService: FetchNetworkServiceProtocol {
    
    private let baseURL: String
    private let urlSession: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private let defaultRequestInterceptors: [RequestInterceptor]
    private let defaultResponseInterceptors: [ResponseInterceptor]
    
    public init(
        baseURL: String,
        urlSession: URLSession,
        encoder: JSONEncoder,
        decoder: JSONDecoder,
        defaultRequestInterceptors: [RequestInterceptor],
        defaultResponseInterceptors: [ResponseInterceptor]
    ) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.encoder = encoder
        self.decoder = decoder
        self.defaultRequestInterceptors = defaultRequestInterceptors
        self.defaultResponseInterceptors = defaultResponseInterceptors
    }
    
    public func perform(_ request: FetchNetworkRequest) async throws {
        
        try await execute(request)
    }
    
    public func perform<T: Decodable>(_ request: FetchNetworkRequest) async throws -> T {
        
        let response: FetchNetworkResponse = try await execute(request)
        let responseObject: T = try response.object(with: decoder)
        return responseObject
    }
    
    // MARK: Helpers
    @discardableResult
    private func execute(_ request: FetchNetworkRequest) async throws -> FetchNetworkResponse {
        
        let urlRequest = try request.urlRequest(baseURL: baseURL,
                                                encoder: encoder,
                                                defaultRequestInterceptors: defaultRequestInterceptors)
        
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)
        
        let response = try FetchNetworkResponse(data: data,
                                                urlResponse: urlResponse)
        
        try defaultResponseInterceptors.forEach { interceptor in
            try interceptor.intercept(response)
        }
        
        if response.isValid {
            return response
        }
        
        throw handleInvalid(response)
    }
    
    private func handleInvalid(_ response: FetchNetworkResponse) -> FetchNetworkError {
        
        if let error: ErrorBody = try? response.object(with: decoder) {
            return FetchNetworkError.reason(error.reason)
        }
        
        return FetchNetworkError.generic
    }
    
}

fileprivate struct ErrorBody: Decodable {
    let reason: String
}
