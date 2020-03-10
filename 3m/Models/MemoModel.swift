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
  var id:String = "id hoge"
  var fact:String
  var abstruct:String
  var product:String
  var createdAt:Date = Date()
}

class MemoModel {
  let db = Firestore.firestore()
  let memos:Array<Memo> = MemoModel.getAllMemo()
  
  static func getAllMemo() -> Array<Memo> {
    let me:UserModel = UserModel.getMe()
    let db = Firestore.firestore()
    
    db.collection("users").document(me.uuid).collection("memos").getDocuments { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        print("print id")
        for document in querySnapshot!.documents {
          print("\(document.documentID) => \(document.data())")
        }
      }
    }
    return [
      Memo(fact: "test", abstruct: "abs", product: "String")
    ]
  }
}
