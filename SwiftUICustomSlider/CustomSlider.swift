//
//  CustomSlider.swift
//  SwiftUICustomSlider
//
//  Created by Sercan YİĞİT on 20.02.2022.
//

import SwiftUI
import UIKit

func getRect() -> CGRect {
    return UIScreen.main.bounds
}

struct CustomSlider<Content: View> : UIViewRepresentable {
    var content: Content
    @Binding var offset: CGFloat
    var pickerCount: Int
    
    init(pickerCount: Int, offset: Binding<CGFloat>, @ViewBuilder content: @escaping ()-> Content) {
        self.content = content()
        self._offset = offset
        self.pickerCount = pickerCount
    }
    func makeCoordinator() -> Coordinator {
        return CustomSlider.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let swiftUIView = UIHostingController(rootView: content).view!
        
        //each pickerCount have 4 subpicker
        //6*4 = 24 + 6 = 30
        let width =  CGFloat((pickerCount * 5) * 20) + getRect().width - 50
        
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator : NSObject, UIScrollViewDelegate {
        var parent : CustomSlider
        
        init(parent : CustomSlider) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            let value = (offset /  20).rounded(.toNearestOrAwayFromZero)
            scrollView.setContentOffset(CGPoint(x: value * 20 , y : 0), animated: false)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                let offset = scrollView.contentOffset.x
                let value = (offset /  20).rounded(.toNearestOrAwayFromZero)
                scrollView.setContentOffset(CGPoint(x: value * 20 , y : 0), animated: false)
            }
        }
    }
}
