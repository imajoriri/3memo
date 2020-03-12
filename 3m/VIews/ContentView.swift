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
    func deleteMemo(offsets: IndexSet) {
        let memo = self.memos[offsets.first!]
        MemoModel.delete(memo: memo)
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack{
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
            .onAppear(perform: {
                MemoModel.getAllMemo() {memos in
                    self.memos = memos
                }
            })
        }
    }
}
