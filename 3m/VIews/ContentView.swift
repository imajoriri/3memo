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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
