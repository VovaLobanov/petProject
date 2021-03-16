//
//  UsersInteractor.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import Foundation

final class UsersInteractor {
  let output: UsersInteractorOutput

  init(with output: UsersInteractorOutput) {
    self.output = output
  }
}

extension UsersInteractor: UsersInteractorInput {
  func fetchUsers() {
    APIService.shared.fetchUsers(completion: { [weak self] users, error in
      guard error == nil,
            let users = users else {
        self?.output.usersFetchingFailed()
        return
      }
      CacheService.shared.saveUsers(users: users)
      self?.output.usersFetched(users: users)
    })
  }
}
