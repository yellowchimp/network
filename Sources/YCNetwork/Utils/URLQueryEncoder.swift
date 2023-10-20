//
//  URLQueryEncoder.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public struct URLQueryEncoder {
    
    public init() {}
    
    public func encode<T: Encodable>(_ value: T) throws -> String {
        
        let encoder = JSONEncoder()
        
        let jsonData = try encoder.encode(value)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
        
        var components = URLComponents()
        components.queryItems = json?.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        
        guard let queryString = components.percentEncodedQuery else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Failed to encode value to query string"))
        }
        
        return queryString
    }
    
    public func encodeToDictionary<T: Encodable>(_ value: T) throws -> [String: String] {
        
        let encoder = JSONEncoder()
        
        let jsonData = try encoder.encode(value)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
        
        guard let validJSON = json else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Failed to encode value to JSON"))
        }
        
        var output: [String: String] = [:]
        for (key, value) in validJSON {
            output[key] = String(describing: value)
        }
        
        return output
    }
}
