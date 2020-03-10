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
    let text:String
    let systemName:String
    
    var body: some View {
      HStack {
        HStack {
          Image(systemName: systemName)
            .resizable()
            .frame(width: 11.0, height: 11.0)
          Text(text)
            .offset(x: -5)
            .font(.system(size: 11.0))
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8.0)
      }
      .background(AppColor.main.opacity(0.15))
      .foregroundColor(AppColor.main)
      .cornerRadius(20)
  }
}


struct MemoTagView_Previews: PreviewProvider {
    static var previews: some View {
        MemoTagView(text: "事実", systemName: "pencil")
    }
}
