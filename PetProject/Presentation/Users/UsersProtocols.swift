//
//  UsersProtocols.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

protocol UsersViewInput {
  func updateUI()
}

protocol UsersViewOutput {
  func viewDidLoad()
  func userSelected(at index: Int)
  func didPullToRefresh()
  var users: [User] { get }
}

protocol UsersInteractorInput {
  func fetchUsers()
}

protocol UsersInteractorOutput {
  func usersFetched(users: [User])
  func usersFetchingFailed()
}

protocol UsersRouterInput {
  func openRepositories(for user: User)
}
