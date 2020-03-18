//
//  MultilineFieldView.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/10.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI

struct MultilineFieldView: UIViewRepresentable {
    @Binding var text: String
    var openKeyboard:Bool
    
    let onEditingChanged: (Bool) -> Void
    
    init(text: Binding<String>, openKeyboard:Bool = false, onEditingChanged: @escaping (Bool) -> Void = {_ in}) {
        self._text = text
        self.openKeyboard = openKeyboard
        self.onEditingChanged = onEditingChanged
    }
    
    func makeCoordinator() -> MultilineFieldCoordinator {
        MultilineFieldCoordinator(target: self, onEditingChanged: onEditingChanged)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: CGFloat(17))
        if self.openKeyboard {
            textView.becomeFirstResponder()
        }
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != text {
            textView.text = text
        }
    }
}

class MultilineFieldCoordinator : NSObject, UITextViewDelegate {
    let target: MultilineFieldView
    let onEditingChanged: (Bool) -> Void
    
    init(target: MultilineFieldView, onEditingChanged: @escaping (Bool) -> Void = {_ in}) {
        self.target = target
        self.onEditingChanged = onEditingChanged
    }
    
    func textViewDidChange(_ textView: UITextView) {
        target.text = textView.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        onEditingChanged(true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        onEditingChanged(false)
    }
}
