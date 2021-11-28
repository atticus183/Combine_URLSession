//
//  UserService.swift
//  Combine_URLSession
//
//  Created by Josh R on 5/19/21.
//

import Combine
import Foundation

protocol UserServiceProtocol {
    func userPublisher() -> AnyPublisher<[Users], Error>
}

final class UserService: UserServiceProtocol {
    private let userEndpointString = "https://jsonplaceholder.typicode.com/users"

    private var userEndpointURL: URL {
        URL(string: userEndpointString)!
    }

    private let jsonDecoder = JSONDecoder()

    func userPublisher() -> AnyPublisher<[Users], Error> {
        return URLSession.shared.dataTaskPublisher(for: userEndpointURL)
            .map { $0.data }
            .decode(type: [Users].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
