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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
    }
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
      ZStack {
        VStack{
            ScrollView {
              VStack(alignment: .leading) {
                HStack {
                  ZStack {
                    if self.segmentSelection == 0 {
                        Capsule()
                            .fill(Color(.systemGray6))
                            .frame(width: 45, height: 37)
                        Text(String(self.memos.count))
                            .font(.system(size: 16.0))
                            .fontWeight(.bold)
                            .foregroundColor(Color.appBlue)
                    }
                  }
                  .position(x: 100, y: -27)
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
            Spacer()
                .frame(height: 0)
            Rectangle()
                .frame(height: 0.5)
                .background(Color(.systemGroupedBackground))
            HStack{
                Spacer()
                Button(action: {
                  UIImpactFeedbackGenerator().impactOccurred()
                }) {
                  NavigationLink(destination: MemoDetailView(memo: Memo())) {
                      ZStack {
                          Image(systemName: "square.and.pencil")
                            .foregroundColor(.appBlue)
                            .font(.system(size: 20, weight: .regular, design: .default))
                    }
                  }
                }.padding(.trailing,16)
            }
            .frame(height: 40)
            .background(Color.white)
        }
        VStack {
          Spacer()
            SegmentedControlView(selection: self.$segmentSelection)
                .frame(height: 44)
                .padding(.leading, 12)
                .padding(.trailing, 12)
            Spacer()
            .frame(height: 44 + 20)
        }
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
