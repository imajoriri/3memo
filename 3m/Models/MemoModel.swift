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
        complete([])
      } else {
        for document in querySnapshot!.documents {
          var fact = ""
          if let bindFact = document.get("fact") as? String { fact = bindFact }
          var abstruct = ""
          if let bindAbstruct = document.get("abstruct") as? String { abstruct = bindAbstruct }
          var product = ""
          if let bindProduct = document.get("product") as? String { product = bindProduct }
          results.append(Memo(id: "j", fact: fact, abstruct: abstruct, product: product))
        }
      }
      complete(results)
    }
  }
}
