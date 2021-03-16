//
//  UsersPresenter.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import Foundation

final class UsersPresenter {
  var view: UsersViewInput?
  var interactor: UsersInteractorInput?
  var router: UsersRouterInput?

  var users: [User] = []
}

extension UsersPresenter: UsersInteractorOutput {
  func usersFetched(users: [User]) {
    self.users = users
    view?.updateUI()
  }

  func usersFetchingFailed() {
    let latestSavedUsers = CacheService.shared.getUsers()
    users = latestSavedUsers
    view?.updateUI()
  }
}

extension UsersPresenter: UsersViewOutput {
  func didPullToRefresh() {
    fetchUsers()
  }

  func viewDidLoad() {
    fetchUsers()
  }

  func userSelected(at index: Int) {
    let selectedUser = users[index]
    router?.openRepositories(for: selectedUser)
  }

  private func fetchUsers() {
    interactor?.fetchUsers()
  }
}
