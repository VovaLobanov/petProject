//
//  RepositoriesInteractor.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import Foundation

final class RepositoriesInteractor {
  let output: RepositoriesInteractorOutput

  init(with output: RepositoriesInteractorOutput) {
    self.output = output
  }
}

 extension RepositoriesInteractor: RepositoriesInteractorInput {
  func fetchRepositories(for userLogin: String) {
    APIService.shared.fetchRepositories(userLogin: userLogin, completion: { [weak self] repositories, error in
      guard error == nil,
            let repositories = repositories else {
        self?.output.repositoriesFetchingFailed()
        return
      }
      CacheService.shared.saveRepositories(for: userLogin, repositories: repositories)
      self?.output.repositoriesFetched(repositories: repositories)
    })
  }
}
