//
//  RoundSegmentView.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/09.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

struct RoundSegmentView: View {
  @Binding var selection:Int
  let labels:[String]
  
  let backgroundColor:Color = Color(red: 241/255, green: 241/255, blue: 243/255)
  
  func buttonFrameWidth() -> CGFloat {
    return CGFloat((UIScreen.main.bounds.width / CGFloat(self.labels.count)) - 14)
  }
  
  var body: some View {
    HStack {
      ForEach(0..<self.labels.count, id: \.self) {index in
        Button(action: {
          self.selection = index
        }) {
          Text(self.labels[index])
            .font(.system(size: 14.0))
            .foregroundColor(self.selection == index ? Color.white : AppColor.main)
            .frame(width: self.buttonFrameWidth(), height: 32)
            .background(
              RoundedRectangle(cornerRadius: 30)
                .fill(self.selection == index ? AppColor.main : self.backgroundColor)
          )
        }
      }
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 38)
    .padding(.horizontal, 4.0)
    .background(
      RoundedRectangle(cornerRadius: 30)
        .fill(backgroundColor)
    )
  }
}

struct RoundSegmentView_Previews: PreviewProvider {
  static var previews: some View {
    RoundSegmentView(selection: .constant(0), labels: ["全て", "事実", "抽象的", "プロダクト"])
  }
}
