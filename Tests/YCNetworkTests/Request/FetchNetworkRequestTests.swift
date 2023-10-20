//
//  FetchNetworkRequestTests.swift
//  
//
//  Created by Filipe Dias on 20/10/2023.
//

import XCTest
@testable import YCNetwork

final class FetchNetworkRequestTests: XCTestCase {

    var subject: FetchNetworkRequest!
    
    override func tearDownWithError() throws {
        subject = nil
        try super.tearDownWithError()
    }
    
    func testDefaultHeaders() throws {
        
        subject = .get(URLPath: "/some-path")
        
        let interceptors: [RequestInterceptor] = [
            ContentTypeInterceptor.json(),
            AcceptLanguageInterceptor(value: "en")
        ]
        
        let request = try subject.urlRequest(baseURL: "http://localhost:8080/api",
                                             defaultRequestInterceptors: interceptors)
        
        let header = try XCTUnwrap(request.allHTTPHeaderFields)
        XCTAssertEqual(header.count, 2)
        XCTAssertEqual(header["Accept-Language"], "en")
        XCTAssertEqual(header["Content-Type"], "application/json; charset=utf-8")
    }
    
    func testDefaultHeadersWithAuthorization() throws {
        
        let auth: AuthorizationInterceptor = .basic(value: "username:password")
        
        subject = .get(URLPath: "/some-path", interceptors: [auth])
        
        let interceptors: [RequestInterceptor] = [
            ContentTypeInterceptor.json(),
            AcceptLanguageInterceptor(value: "en")
        ]
        
        let request = try subject.urlRequest(baseURL: "http://localhost:8080/api",
                                             defaultRequestInterceptors: interceptors)
        
        let header = try XCTUnwrap(request.allHTTPHeaderFields)
        XCTAssertEqual(header.count, 3)
        XCTAssertEqual(header["Accept-Language"], "en")
        XCTAssertEqual(header["Content-Type"], "application/json; charset=utf-8")
        XCTAssertEqual(header["Authorization"], "Basic username:password")
    }

}
