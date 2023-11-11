//
//  RequestInterceptor.swift
// 
//
//  Created by Filipe Dias on 19/10/2023.
//

import Foundation

public protocol RequestInterceptor {
    
    func intercept(_ request: inout URLRequest) async throws
}
