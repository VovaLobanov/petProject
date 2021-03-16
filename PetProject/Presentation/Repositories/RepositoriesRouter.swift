//
//  RepositoriesRouter.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

final class RepositoriesContainer {
  let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  class func assemble(with input: RepositoriesModuleInput) -> RepositoriesContainer {
    let presenter = RepositoriesPresenter(userLogin: input.userLogin)

    let viewController = RepositoriesVC(with: presenter)
    presenter.view = viewController

    let router = RepositoriesRouter()
    presenter.router = router

    let interactor = RepositoriesInteractor(with: presenter)
    presenter.interactor = interactor

    return RepositoriesContainer(viewController: viewController)
  }
}

final class RepositoriesRouter: RepositoriesRouterInput {
  func openRepositoryDetail(homepageUrl: String) {
    if let url = URL(string: homepageUrl) {
        UIApplication.shared.open(url)
    }
  }
}
