//
//  UIKitTableView.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import Foundation
import SwiftUI


struct UIKitTableView: UIViewRepresentable {
    var users: [User]
    var onRefresh: (() -> Void)? = nil
    var onSelectUser: ((User) -> Void)? = nil
    var onDeleteUser: ((Int) -> Void)? = nil
    let homeVM: HomeVM
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            users: users,
            onRefresh: onRefresh,
            onSelectUser: onSelectUser,
            onDeleteUser: onDeleteUser
        )
    }

    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.rowHeight = 70
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.contentInset = UIEdgeInsets(top: Constants.safeAreaInset.top, left: 0, bottom: Constants.safeAreaInset.bottom, right: 0)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        return tableView
    }

    func updateUIView(_ uiView: UITableView, context: Context) {
        context.coordinator.users = users
        uiView.reloadData()
    }

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var users: [User]
        var onRefresh: (() -> Void)?
        var onSelectUser: ((User) -> Void)?
        var onDeleteUser: ((Int) -> Void)?
        
        init(users: [User], onRefresh: (() -> Void)?, onSelectUser: ((User) -> Void)?, onDeleteUser: ((Int) -> Void)?) {
            self.users = users
            self.onRefresh = onRefresh
            self.onSelectUser = onSelectUser
            self.onDeleteUser = onDeleteUser
        }

        // MARK: - Data Source
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let user = users[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = "\(user.firstName) \(user.lastName)"
            cell.detailTextLabel?.text = user.email
            cell.imageView?.image = UIImage(systemName: "person.crop.circle")
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        // MARK: - Delegate
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedUser = users[indexPath.row]
            onSelectUser?(selectedUser)
            tableView.deselectRow(at: indexPath, animated: true)
        }

        // MARK: - Swipe to delete
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
                self.onDeleteUser?(indexPath.row)
                completion(true)
            }
            let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, completion in
                
            }
            return UISwipeActionsConfiguration(actions: [delete, edit])
        }

        // MARK: - Pull to refresh
        @objc func handleRefresh(_ sender: UIRefreshControl) {
            onRefresh?()
            sender.endRefreshing()
        }
    }
}

import UIKit

