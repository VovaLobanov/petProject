//
//  ViewController.swift
//  Smart4AviationTest
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let usersVC = UsersContainer.assemble().viewController
    let navigationController = UINavigationController()
    
    navigationController.pushViewController(navigationController, animated: true)
  }
}
