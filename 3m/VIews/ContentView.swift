//
//  ContentView.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/09.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var segmentSelection:Int = 0
  @State var memos:Array<Memo> = []
  
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView {
          VStack(alignment: .leading) {
            HStack {
              ZStack {
                Capsule()
                  .fill(Color.gray.opacity(0.15))
                  .frame(width: 45, height: 37)
                Text(String(self.memos.count))
                  .font(.system(size: 15.0))
                  .fontWeight(.bold)
              }
              .position(x: 110, y: -27)
            }.frame(height: 5)
            
            ForEach(self.memos) {memo in
              NavigationLink(destination: MemoDetailView(memo: memo)) {
                Group {
                  MemoListRowView(memo: memo)
                    .navigationBarBackButtonHidden(true)
                }
              }
              Divider()
            }
          }
          .padding(.horizontal)
          
        }
        .navigationBarTitle(Text("メモ"))
        .navigationBarItems(trailing:
          NavigationLink(destination: MemoDetailView(memo: Memo())) {
            Text("作成")
          }
        )
        VStack {
          Spacer()
          RoundSegmentView(selection: self.$segmentSelection, labels: ["全て", "事実", "抽象化", "プロダクト"])
            .padding(.bottom, 20.0)
        }
      }
    }
    .onAppear(perform: {
      MemoModel.getAllMemo() {memos in
        self.memos = memos
      }
    })
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
