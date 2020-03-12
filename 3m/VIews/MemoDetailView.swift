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
    @State var memo:Memo
    @State var isShowCompleteButton:Bool = false
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    func saveMemo() {
        if self.memo.fact.isEmpty && self.memo.abstruct.isEmpty && self.memo.product.isEmpty {
            MemoModel.delete(memo: self.memo)
        } else {
            MemoModel.save(memo: self.memo)
        }
    }
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                Text("事実")
                    .font(.headline).padding(.bottom, -5.0)
                MultilineFieldView(text: self.$memo.fact, onEditingChanged: {bool in
                    self.isShowCompleteButton = bool
                    self.saveMemo()
                })
                    .frame(height: 100)
                
                Text("抽象的")
                    .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
                MultilineFieldView(text: self.$memo.abstruct, onEditingChanged: {bool in
                    self.isShowCompleteButton = bool
                    self.saveMemo()
                })
                    .frame(height: 100)
                
                Text("プロダクト")
                    .font(.headline).padding(.bottom, -5.0).padding(.top, 20)
                MultilineFieldView(text: self.$memo.product, onEditingChanged: {bool in
                    self.isShowCompleteButton = bool
                    self.saveMemo()
                })
                    .frame(height: 100)
                
                Spacer()
            }
            .padding()
            .keyboardObserving()
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.endEditing()
                self.saveMemo()
            }) {
                if self.isShowCompleteButton {
                    Text("完了")
                }
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
