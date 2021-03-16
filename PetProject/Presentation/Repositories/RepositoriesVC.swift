//
//  RepositoriesVC.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

final class RepositoriesVC: UIViewController {
  
  struct Constants {
    static let title = "Repositories"
    static let repositoriesViewNibName = "RepositoriesView"
    static let repositoryCellNibName = "RepositoryCell"
    static let repositoryCellReuseId = "repositoryCell"
  }

  private var output: RepositoriesViewOutput
  private let refreshControl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    return refresh
  }()

  @IBOutlet weak var repositoriesTableView: UITableView!
  @IBOutlet weak var noDataLabel: UILabel!

  init(with output: RepositoriesViewOutput) {
    self.output = output
    super.init(nibName: Constants.repositoriesViewNibName, bundle: nil)
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

extension RepositoriesVC: RepositoriesViewInput {
  func updateUI() {
    DispatchQueue.main.async { [weak self] in
      self?.repositoriesTableView.reloadData()
      self?.refreshControl.endRefreshing()

      self?.noDataLabel.isHidden = !(self?.output.repositories.isEmpty ?? false)
    }
  }
}

extension RepositoriesVC {
  private func configureUI() {
    configureTableView()
    navigationItem.title = Constants.title
    noDataLabel.isHidden = true
    refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
  }

  private func configureTableView() {
    repositoriesTableView.register(UINib(nibName: Constants.repositoryCellNibName, bundle: nil),
                                   forCellReuseIdentifier: Constants.repositoryCellReuseId)
    repositoriesTableView.addSubview(refreshControl)
  }

  @objc private func didPullToRefresh() {
    output.didPullToRefresh()
  }
}

extension RepositoriesVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    output.repositories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repositoryCellReuseId,
                                                   for: indexPath) as? RepositoryCell else {
      return UITableViewCell()
    }
    cell.configure(with: output.repositories[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    output.repositorySelected(at: indexPath.row)
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    UIView()
  }
}
