//
//  UserCell.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/14/21.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
  @IBOutlet weak var avatar: UIImageView!
  @IBOutlet weak var login: UILabel!

  func configure(with user: User) {
    login.text = user.login
    avatar.kf.setImage(with: URL(string: user.avatarUrl ?? ""))
  }
}
