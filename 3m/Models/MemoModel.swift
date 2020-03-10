//
//  MemoModel.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/10.
//  Copyright © 2020 imajo. All rights reserved.
//

import Foundation
import Firebase

struct Memo: Identifiable {
  var id:String
  var fact:String
  var abstruct:String
  var product:String
  var createdAt:Date = Date()
}

class MemoModel {
  var db:Firestore = Firestore.firestore()
  
  static func getAllMemo(complete: @escaping(Array<Memo>)->() ) {
    let me:UserModel = UserModel.getMe()
    let db = Firestore.firestore()
    var results:Array<Memo> = []
    
    db.collection("users").document(me.uuid).collection("memos").getDocuments { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {

          let fact = document.get("fact") as! String
          // TODO: 非同期
          results.append(Memo(id: "j", fact: fact, abstruct: "abs", product: "String"))
          print(fact)
        }
      }
      complete(results)
    }
  }
}
