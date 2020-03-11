//
//  MemoDetailView.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/09.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

import SwiftUI
import KeyboardObserving

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

struct MemoDetailView: View {
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State var memo:Memo
  
  private func endEditing() {
    UIApplication.shared.endEditing()
  }
  
  var body: some View {
    ScrollView {
      
      VStack(alignment: .leading) {
        Text("事実")
          .font(.headline).padding(.bottom, -5.0)
        MultilineFieldView(text: self.$memo.fact)
          .frame(height: 100)
        
        Text("抽象的")
          .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
        MultilineFieldView(text: self.$memo.abstruct)
          .frame(height: 100)
        
        Text("プロダクト")
          .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
        MultilineFieldView(text: self.$memo.product)
          .frame(height: 100)
        
        Spacer()
      }
      .padding()
      .keyboardObserving()
    }
    .navigationBarItems(trailing:
      Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
        MemoModel.save(memo: self.memo)
      }) {
        Text("完了")
      }
    )
      .navigationBarTitle(Text(""))
      .onTapGesture {
        self.endEditing()
    }
  }
}

//struct MemoDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    MemoDetailView()
//  }
//}
