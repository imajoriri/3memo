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
                Text("25")
                  .font(.system(size: 15.0))
                  .fontWeight(.bold)
              }
              .position(x: 110, y: -27)
            }.frame(height: 5)
            
            ForEach(0..<11) {_ in
              NavigationLink(destination: MemoDetailView()) {
                Group {
                  MemoListRowView()
                  .navigationBarBackButtonHidden(true)
                }
              }
              Divider()
            }
          }
          .padding(.horizontal)
          
        }
        .navigationBarTitle(Text("メモ"))
        VStack {
          Spacer()
          RoundSegmentView(selection: self.$segmentSelection, labels: ["全て", "事実", "抽象化", "プロダクト"])
            .padding(.bottom, 20.0)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
