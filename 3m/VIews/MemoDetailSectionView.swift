//
//  MemoDetailSectionView.swift
//  3m
//
//  Created by 坂井岳 on 2020/03/12.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

struct MemoDetailSectionView: View {
    let insets = EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 10)
    let color:Color
    let imageName:String
    let title:String
    var body: some View {
        HStack(spacing: 4){
            Image(systemName: imageName)
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
        .padding(insets)
        .background(color)
        .cornerRadius(8)
    }
}
