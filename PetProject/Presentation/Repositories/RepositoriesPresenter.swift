//
//  RepositoriesPresenter.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import Foundation

final class RepositoriesPresenter {
  var view: RepositoriesViewInput?
  var interactor: RepositoriesInteractorInput?
  var router: RepositoriesRouterInput?
  
  var repositories: [Repository] = []
  var userLogin: String

  init(userLogin: String) {
    self.userLogin = userLogin
  }
}

extension RepositoriesPresenter: RepositoriesInteractorOutput {
  func repositoriesFetched(repositories: [Repository]) {
    self.repositories = repositories
    view?.updateUI()
  }

  func repositoriesFetchingFailed() {
    let latestSavedRepositories = CacheService.shared.getRepositories(for: userLogin)
    repositories = latestSavedRepositories
    view?.updateUI()
  }
}

extension RepositoriesPresenter: RepositoriesViewOutput {
  func didPullToRefresh() {
    fetchRepositories()
  }

  func repositorySelected(at index: Int) {
    guard let selectedRepositoryUrl = repositories[index].homepageUrl else { return }
    router?.openRepositoryDetail(homepageUrl: selectedRepositoryUrl)
  }

  func viewDidLoad() {
    fetchRepositories()
  }

  private func fetchRepositories() {
    interactor?.fetchRepositories(for: userLogin)
  }
}
