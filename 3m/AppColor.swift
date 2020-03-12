//
//  AppColor.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/09.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

struct AppColor {
    static let main:Color = Color(red: 0, green: 178/255, blue: 39/255)
    static let base:Color = Color(red: 241/255, green: 242/255, blue: 246/255)
    static let textGray:Color = Color(red: 128/255, green: 128/255, blue: 128/255)
    static let backcolor:Color = Color(red: 241/255, green: 242/255, blue: 246/255)
}
extension Color {
    
    func uiColor() -> UIColor {
        
        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
    
    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        
        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
    //AppColor
    static let appBlue = Color("AppBlue")
    static let appGreen = Color("AppGreen")
    static let appOrange = Color("AppOrange")
    static let appPrimary = Color("AppPrimary")
}
