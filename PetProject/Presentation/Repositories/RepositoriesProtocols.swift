//
//  RepositoriesProtocols.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

struct RepositoriesModuleInput {
  var userLogin: String
}

protocol RepositoriesViewInput {
  func updateUI()
}

protocol RepositoriesViewOutput {
  func viewDidLoad()
  func repositorySelected(at index: Int)
  func didPullToRefresh()
  var repositories: [Repository] { get }
}

protocol RepositoriesInteractorInput {
  func fetchRepositories(for userLogin: String)
}

protocol RepositoriesInteractorOutput {
  func repositoriesFetched(repositories: [Repository])
  func repositoriesFetchingFailed()
}

protocol RepositoriesRouterInput {
  func openRepositoryDetail(homepageUrl: String)
}
