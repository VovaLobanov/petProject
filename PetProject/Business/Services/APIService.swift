//
//  APIService.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import Foundation
import GithubAPI

final class APIService: GitHubApi {}

protocol APIServiceInterface {
  static var shared: APIServiceInterface { get }
  func fetchUsers(completion: @escaping ([User]?, Error?) -> Void)
  func fetchRepositories(userLogin: String, completion: @escaping ([Repository]?, Error?) -> Void)
}

public class GitHubApi: APIServiceInterface {
  static let shared: APIServiceInterface = GitHubApi()

  private let userApi = UserAPI()
  private let repositoriesApi = RepositoriesAPI()

  func fetchUsers(completion: @escaping ([User]?, Error?) -> Void) {
      userApi.getAllUsers(since: "", completion: { users, error in
        guard error == nil,
              let users = users else {
          completion(nil, error)
          return
        }
        let fetchedUsers = users.map { fetchedUser in
          User(userId: fetchedUser.id,
               login: fetchedUser.login,
               avatarUrl: fetchedUser.avatarUrl,
               reposUrl: fetchedUser.reposUrl)
        }
        completion(fetchedUsers, nil)
    })
  }

  func fetchRepositories(userLogin: String, completion: @escaping ([Repository]?, Error?) -> Void) {
    repositoriesApi.repositories(user: userLogin, completion: { fetchedRepositories, error in
      guard error == nil,
            let fetchedRepositories = fetchedRepositories else {
        completion(nil, error)
        return
      }
      let repositories = fetchedRepositories.map { fetchedRepository in
        Repository(repositoryId: fetchedRepository.id,
                   fullName: fetchedRepository.fullName,
                   creationDate: fetchedRepository.createdAt,
                   lastUpdate: fetchedRepository.updatedAt,
                   userId: fetchedRepository.owner?.id,
                   homepageUrl: fetchedRepository.homepage)
      }
      completion(repositories, nil)
    })
  }
}
