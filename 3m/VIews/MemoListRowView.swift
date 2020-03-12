//
//  MemoListRowView.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/09.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

struct MemoListRowView: View {
    let memo:Memo
    let insets:EdgeInsets = EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0)
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Text(self.memo.fact)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(UIColor.label))
                    .lineLimit(1)
                Spacer()
            }
            HStack(spacing:4){
                if !memo.fact.isEmpty {
                    MemoTagView(tagText: "事実", imageName: "pencil", color: .appBlue)
                }
                if !memo.abstruct.isEmpty {
                    MemoTagView(tagText: "抽象化", imageName: "lightbulb", color: .appOrange)
                }
                if !memo.product.isEmpty {
                    MemoTagView(tagText: "プロダクト", imageName: "desktopcomputer", color: .appGreen)
                }
                Spacer()
            }
        }
        .padding(insets)
    }
}

struct MemoListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
