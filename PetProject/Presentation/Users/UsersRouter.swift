//
//  UsersRouter.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

final class UsersContainer {
  let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  class func assemble() -> UsersContainer {
    let presenter = UsersPresenter()

    let viewController = UsersVC(with: presenter)
    presenter.view = viewController

    let router = UsersRouter(viewController: viewController)
    presenter.router = router

    let interactor = UsersInteractor(with: presenter)
    presenter.interactor = interactor

    return UsersContainer(viewController: viewController)
  }
}

final class UsersRouter: UsersRouterInput {
  let viewController: UIViewController?

  init(viewController: UIViewController?) {
    self.viewController = viewController
  }

  func openRepositories(for user: User) {
    guard let userLogin = user.login else { return }
    let repositoriesModuleInput = RepositoriesModuleInput(userLogin: userLogin)
    let repositoriesVC = RepositoriesContainer.assemble(with: repositoriesModuleInput).viewController
    viewController?.navigationController?.pushViewController(repositoriesVC, animated: true)
  }
}
