//
//  UserModel.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/10.
//  Copyright © 2020 imajo. All rights reserved.
//

import Foundation
import Firebase

class UserModel {
  let uuid:String //UIDevice.current.identifierForVendor!.uuidString
  
  init(uuid:String) {
    self.uuid = uuid
  }
  
  static func getMe() -> UserModel {
    let uuid = "first_user_id"
    return UserModel(uuid: uuid)
  }
}
