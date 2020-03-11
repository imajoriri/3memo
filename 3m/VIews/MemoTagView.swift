//
//  MemoTagView.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/09.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

import SwiftUI

struct MemoTagView: View {
    let font:Font = .system(size: 12, weight: .bold, design: .default)
    let tagPadding = EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 6)
    let tagText:String
    let imageName:String
    let color:Color
    var body: some View {
        HStack(spacing:3){
            Image(systemName: imageName)
                .foregroundColor(color)
                .font(.system(size: 11, weight: .semibold, design:.default))
            Text(tagText)
                .foregroundColor(color)
                .font(font)
        }
        .padding(tagPadding)
        .background(color.opacity(0.15))
        .cornerRadius(6)
    }
}


struct MemoTagView_Previews: PreviewProvider {
    static var previews: some View {
        MemoTagView(tagText: "事実", imageName: "pencil", color: Color.green)
    }
}
