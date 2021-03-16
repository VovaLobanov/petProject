//
//  UserCell.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/14/21.
//

import UIKit

class RepositoryCell: UITableViewCell {

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var creationDate: UILabel!
  @IBOutlet weak var lastUpdateDate: UILabel!

  func configure(with repository: Repository) {
    name.text = repository.fullName
    creationDate.text = repository.creationDate
    lastUpdateDate.text = repository.lastUpdate
  }
}
