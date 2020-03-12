//
//  SegmentedControlView.swift
//  3m
//
//  Created by 坂井岳 on 2020/03/12.
//  Copyright © 2020 imajo. All rights reserved.
//

import SwiftUI
import BetterSegmentedControl

struct SegmentedControlView: UIViewRepresentable {
    @Binding var selection:Int
    let segmentControl = BetterSegmentedControl()
    func makeCoordinator() -> SegmentedControlView.Coordinator {
        return Coordinator(self)
    }
    func makeUIView(context: Context) -> BetterSegmentedControl {
        let font:UIFont = .systemFont(ofSize: 14, weight: .bold)
        segmentControl.segments = LabelSegment.segments(withTitles: ["すべて","事実","抽象化","プロダクト"], numberOfLines: 1, normalBackgroundColor: .systemGroupedBackground, normalFont: font, normalTextColor: .secondaryLabel, selectedBackgroundColor: .systemIndigo, selectedFont: font, selectedTextColor: .white)
        segmentControl.cornerRadius = 22
        segmentControl.indicatorViewInset = 4
        segmentControl.backgroundColor = .systemGroupedBackground
        segmentControl.addTarget(context.coordinator, action: #selector(Coordinator.updateIndex(sender:)), for: .valueChanged)
        return segmentControl
    }

    func updateUIView(_ segmentControl: BetterSegmentedControl, context: Context) {
        segmentControl.setIndex(selection)
    }
}
extension SegmentedControlView {
    class Coordinator: NSObject{
        var segmentControl: BetterSegmentedControl
        var segmentedControlView:SegmentedControlView
        private let feedbackGenerator: UIImpactFeedbackGenerator = {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            return generator
        }()
        
        init(_ view: SegmentedControlView) {
            self.segmentControl = view.segmentControl
            self.segmentedControlView = view
        }
        
        @objc func updateIndex(sender: BetterSegmentedControl) {
            self.segmentedControlView.selection = sender.index
            feedbackGenerator.impactOccurred()
        }
    }
}
