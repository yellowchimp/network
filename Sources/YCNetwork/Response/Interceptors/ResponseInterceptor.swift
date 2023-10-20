//
//  ResponseInterceptor.swift
//
//
//  Created by Filipe Dias on 20/10/2023.
//

import Foundation

public protocol ResponseInterceptor {
    
    func intercept(_ response: FetchNetworkResponse) throws
    
}
