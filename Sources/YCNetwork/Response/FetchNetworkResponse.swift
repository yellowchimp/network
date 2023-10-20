//
//  FetchNetworkResponse.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public struct FetchNetworkResponse {
    
    private let data: Data
    private let status: HTTPResponseStatus
    
    public var isValid: Bool {
        return Set(200...299).contains(status.code)
    }
    
    public var isUnauthorizedCode: Bool {
        return status.code == HTTPResponseStatus.unauthorized.code
    }
    
    init(data: Data,
         urlResponse: URLResponse) throws {
        
        guard
            let httpURLResponse = urlResponse as? HTTPURLResponse
        else {
            throw FetchNetworkError.noHTTPURLResponse
        }
        
        self.data = data
        
        self.status = HTTPResponseStatus(statusCode: httpURLResponse.statusCode)
    }
    
    func object<T: Decodable>(with decoder: JSONDecoder) throws -> T {
        let responseObject: T = try decoder.decode(T.self,
                                                   from: data)
        return responseObject
    }
    
}
