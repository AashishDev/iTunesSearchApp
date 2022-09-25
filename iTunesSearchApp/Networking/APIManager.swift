//
//  APIManager.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

public protocol APIServiceProtocol {
    func execute<T:Codable>(responseType: T.Type, endpoint: EndPoint, completion: @escaping ((Result<T, APIError>) -> Void))
}

public class APIManager:APIServiceProtocol {
    private let remoteService:RemoteServiceProtocol
    private let parser:ResponseParserProtocol
    
    public init(remoteService: RemoteServiceProtocol = RemoteService(), parser: ResponseParserProtocol = ResponseParser()) {
        self.remoteService = remoteService
        self.parser = parser
    }
    
    public  func execute<T>(responseType: T.Type, endpoint: EndPoint, completion: @escaping ((Result<T, APIError>) -> Void)) where T : Decodable, T : Encodable {
        
        guard let url = URL(string: endpoint.path) else {
            completion(.failure(APIError.InValidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.requestType
        print("\n Request Url :\(url)")
        
        self.remoteService.execute(request: urlRequest) { result in
            
            switch result {
            case .success(let data):
                //Parsing here
                self.parser.parse(type: T.self, data: data) { parseResult in
                    
                    switch parseResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure( _):
                        completion(.failure(.unableToParsed))
                    }
                }
                
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
