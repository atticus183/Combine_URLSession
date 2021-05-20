//
//  UserService.swift
//  Combine_URLSession
//
//  Created by Josh R on 5/19/21.
//

import Combine
import Foundation

class UserService {
    let userEndpointString = "https://jsonplaceholder.typicode.com/users"

    var userEndpointURL: URL {
        URL(string: userEndpointString)!
    }

    var jsonDecoder: JSONDecoder {
        JSONDecoder()
    }
    
    func userPublisher() -> AnyPublisher<[Users], Error> {
        return URLSession.shared.dataTaskPublisher(for: userEndpointURL)
            .map { $0.data }
            .decode(type: [Users].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
}
