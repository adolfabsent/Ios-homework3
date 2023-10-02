//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 17.09.2023.
//

import UIKit
import StorageService

class ProfileViewModel {

    let profileHeaderView = ProfileHeaderView()
    var postsData: [Post] = []
    var user: User


    init(user: User) {
        self.user = user

        self.setUser()
        //self.setPosts()
    }

    func setUser() {
        self.profileHeaderView.setUser(avatarImage: user.avatar!, fullName: user.fullName, status: user.status)
    }

   // func setPosts() {
     //   postsData = postExamples
  //  }
}
