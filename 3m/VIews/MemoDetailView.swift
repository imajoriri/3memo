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
    @State var isShowCompleteButton:Bool = true
    
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
                MemoDetailSectionView(color: .appBlue, imageName: "pencil", title: "事実")
                MultilineFieldView(text: self.$memo.fact, openKeyboard: true, onEditingChanged: {bool in
                    self.isShowCompleteButton = bool
                    self.saveMemo()
                })
                    .frame(height: 100)
        
                MemoDetailSectionView(color: .appOrange, imageName: "lightbulb", title: "抽象化")
                MultilineFieldView(text: self.$memo.abstruct, openKeyboard: false, onEditingChanged: {bool in
                    self.isShowCompleteButton = bool
                    self.saveMemo()
                })
                    .frame(height: 100)
        
                MemoDetailSectionView(color: .appGreen, imageName: "desktopcomputer", title: "プロダクト")
                MultilineFieldView(text: self.$memo.product, openKeyboard: false, onEditingChanged: {bool in
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
                        .font(.system(size: 16, weight: .bold, design: .default))
                }
            }
        )
            .navigationBarTitle(Text(""))
            .onTapGesture {
                self.endEditing()
        }
    }
}
