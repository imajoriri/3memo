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
<<<<<<< HEAD
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
                .foregroundColor(Color(UIColor.separator))
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
=======
    func deleteMemo(offsets: IndexSet) {
        let memo = self.memos[offsets.first!]
        MemoModel.delete(memo: memo)
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    List {
                        ForEach(self.memos) {memo in
                            VStack {
                                NavigationLink(destination: MemoDetailView(memo: memo)) {
                                    EmptyView()
                                }
                                Group {
                                    MemoListRowView(memo: memo)
                                        .navigationBarBackButtonHidden(true)
                                }
                            }
                        }
                        .onDelete(perform: self.deleteMemo)
                    }
                    .navigationBarTitle(Text("メモ"))
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            UIImpactFeedbackGenerator().impactOccurred()
                        }) {
                            NavigationLink(destination: MemoDetailView(memo: Memo())) {
                                ZStack {
                                    Circle().fill(Color.appBlue)    .frame(width:44, height: 44)
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 21, weight: .bold, design: .default))
                                }
                            }
                        }
                        .position(x: geometry.size.width - 40, y: geometry.size.height - 100)
                        
                        SegmentedControlView(selection: self.$segmentSelection)
                            .frame(height: 44)
                            .padding(.leading, 12)
                            .padding(.trailing, 12)
                    }
                }
            }
        }
        .onAppear(perform: {
            MemoModel.getAllMemo() {memos in
                self.memos = memos
            }
        })
        
>>>>>>> 6801f85c42a010521592c9620b74c0c0c4ee6d9f
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
