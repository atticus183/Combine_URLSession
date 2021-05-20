//
//  ViewControllerViewModel.swift
//  Combine_URLSession
//
//  Created by Josh R on 5/19/21.
//

import Combine
import Foundation

class ViewControllerViewModel {

    let modelDidChange = PassthroughSubject<Void, Never>()

    private var cancellables = Set<AnyCancellable>()
    let userService: UserService

    var users: [Users] = []

    init(userService: UserService = UserService()) {
        self.userService = userService

        userService.userPublisher().sink { (completion) in
            switch completion {
            case .finished:
                print("user publisher finished")
            case .failure(let error):
                print("user publisher failure. \(error)")
            }
        } receiveValue: { [weak self] users in
            self?.users = users
            self?.modelDidChange.send()
        }.store(in: &cancellables)
    }
}
