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
        UINavigationBar.appearance().tintColor = UIColor.systemIndigo
    }
    func deleteMemo(offsets: IndexSet) {
        let memo = self.memos[offsets.first!]
        MemoModel.delete(memo: memo)
    }
    func isShowMemo(memo:Memo) -> Bool {
        switch self.segmentSelection {
        case 0:
            return true
        case 1:
            if !memo.fact.isEmpty {
                return true
            }
            return false
        case 2:
            if !memo.abstruct.isEmpty {
                return true
            }
            return false
        case 3:
            if !memo.product.isEmpty {
                return true
            }
            return false
        default:
            return true
        }
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack{
                        List {
                            ForEach(self.memos) {memo in
                                if self.isShowMemo(memo: memo) {
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
                            Text(String(self.memos.count)+"件のメモ")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14))
                                .padding(.leading,16)
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
                        .background(Color(UIColor.systemBackground))
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
