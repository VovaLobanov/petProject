//
//  UsersVC.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

final class UsersVC: UIViewController {

  struct Constants {
    static let title = "Users"
    static let usersViewNibName = "UsersView"
    static let userCellNibName = "UserCell"
    static let userCellReuseId = "userCell"
  }

  private var output: UsersViewOutput
  private let refreshControl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    return refresh
  }()

  @IBOutlet weak var usersTableView: UITableView!
  @IBOutlet weak var noDataLabel: UILabel!

  init(with output: UsersViewOutput) {
    self.output = output
    super.init(nibName: Constants.usersViewNibName, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    output.viewDidLoad()
  }
}

extension UsersVC: UsersViewInput {
  func updateUI() {
    DispatchQueue.main.async { [weak self] in
      self?.usersTableView.reloadData()
      self?.refreshControl.endRefreshing()

      self?.noDataLabel.isHidden = !(self?.output.users.isEmpty ?? false)
    }
  }
}

extension UsersVC {
  private func configureUI() {
    configureTableView()
    navigationItem.title = Constants.title
    noDataLabel.isHidden = true
    refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
  }

  private func configureTableView() {
    usersTableView.register(UINib(nibName: Constants.userCellNibName, bundle: nil),
                            forCellReuseIdentifier: Constants.userCellReuseId)
    usersTableView.addSubview(refreshControl)
  }

  @objc private func didPullToRefresh() {
    output.didPullToRefresh()
  }
}

extension UsersVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    output.users.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellReuseId,
                                                   for: indexPath) as? UserCell else {
      return UITableViewCell()
    }
    cell.configure(with: output.users[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    output.userSelected(at: indexPath.row)
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    UIView()
  }
}
