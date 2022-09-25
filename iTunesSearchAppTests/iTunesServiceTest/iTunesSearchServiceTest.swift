//
//  iTunesSearchServiceTest.swift
//  iTunesSearchAppTests
//
//  Created by Aashish Tyagi on 9/25/22.
//

import XCTest
@testable import iTunesSearchApp

class iTunesSearchServiceTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_iTunesRemoteService_withSuccess() async {
        
        let responseModel = iTunesSearchResponse(items: [SearchResultModel(id: 1, name: "a name", assetPath: "http://asset.com/png1")])
        
        let remoteServiceMock =  RemoteServiceMock(responseModel: responseModel)
        let apiManager = APIManager(remoteService: remoteServiceMock)
        let sut =  iTunesSearchService(apiManager: apiManager)
        
        do {
            let result = try await sut.loadItems(query: "john", entity: "song")
            XCTAssertEqual(result.items.count, 1)
        }
        catch let error {
            XCTAssertNil(error)
        }
        
    }
    
    func test_iTunesRemoteService_withFailer() async {
        let remoteServiceMock =  RemoteServiceMock(responseModel: nil)
        let apiManager = APIManager(remoteService: remoteServiceMock)
        let sut =  iTunesSearchService(apiManager: apiManager)
        
        do {
            let result = try await sut.loadItems(query: "john", entity: "song")
            XCTAssertNil(result)
        }
        catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    func test_iTunesResponseParser_withFailer() async {
        
        let remoteServiceMock =  RemoteServiceMock(responseModel: nil)
        let apiManager = APIManager(remoteService: remoteServiceMock)
        let sut =  iTunesSearchService(apiManager: apiManager)
        
        do {
            let result = try await sut.loadItems(query: "john", entity: "song")
            XCTAssertNil(result)
        }
        catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    
}
