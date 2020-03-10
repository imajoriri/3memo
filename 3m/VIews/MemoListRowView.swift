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
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(memo.fact)
        .fontWeight(.bold)
        .padding(.bottom, 0)
      HStack {
        MemoTagView(text: "事実", systemName: "pencil")
      }.padding(.top, 0)
    }
    .padding(.vertical)
    .padding(.horizontal, 0.0)
  }
}

struct MemoListRowView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
