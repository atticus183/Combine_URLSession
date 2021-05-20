//
//  ViewController.swift
//  Combine_URLSession
//
//  Created by Josh R on 5/19/21.
//

import Combine
import UIKit

class ViewController: UIViewController {

    let viewModel = ViewControllerViewModel()

    private var cancellables = Set<AnyCancellable>()

    let userTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "JSON"
        view.backgroundColor = .systemBackground

        userTableView.delegate = self
        userTableView.dataSource = self

        view.addSubview(userTableView)

        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        //MARK: User Subscription
        viewModel.modelDidChange.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.userTableView.reloadData()
            }
        }.store(in: &cancellables)

    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Users"
    }
}