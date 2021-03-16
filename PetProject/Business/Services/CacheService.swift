//
//  CacheService.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import Foundation

protocol CacheServiceInterface {
  static var shared: CacheServiceInterface { get }
  func saveUsers(users: [User])
  func getUsers() -> [User]
  func saveRepositories(for userLogin: String, repositories: [Repository])
  func getRepositories(for userLogin: String) -> [Repository]
}

class CacheService: CacheServiceInterface {
  struct Constants {
    static let usersKey = "users"
    static let repositoriesKey = "repositories"
  }

  static let shared: CacheServiceInterface = CacheService()

  func saveUsers(users: [User]) {
    let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: users, requiringSecureCoding: false)
    UserDefaults.standard.setValue(encodedData, forKey: Constants.usersKey)
  }

  func getUsers() -> [User] {
    let decoded = UserDefaults.standard.object(forKey: Constants.usersKey) as! Data
    if let users = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [User] {
      return users
    } else {
      return []
    }
  }

  func saveRepositories(for userLogin: String, repositories: [Repository]) {
    let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: repositories, requiringSecureCoding: false)
    UserDefaults.standard.setValue(encodedData, forKey: Constants.repositoriesKey + userLogin)
  }

  func getRepositories(for userLogin: String) -> [Repository] {
    let decoded = UserDefaults.standard.object(forKey: Constants.usersKey + userLogin) as! Data
    if let repositories = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [Repository] {
      return repositories
    } else {
      return []
    }
  }
}
