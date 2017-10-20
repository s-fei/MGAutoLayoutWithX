//
//  AutoLayoutWithTop.swift
//  MGAutoLayoutWithX
//
//  Created by song on 2017/10/20.
//

import UIKit

/*! 自适应顶部View */
extension UIViewController{
    /*! 坐标写死的自适应 */
    func mg_autoLayoutTopWithFrame(subView:UIView) {
        if subView.isUIView() {
            mg_autoLayoutWithFrameHeight(subView: subView)
        }
        else {
            mg_autoLayoutWithFrameTop(subView: subView)
        }
    }
    
    /*! 约束自适应 */
    func mg_autoLayoutTopWithConstraints(subView:UIView) {
        if subView.isUIView() {
            mg_autoLayoutWithConstraintHeight(subView: subView)
        }
        else {
            mg_autoLayoutWithConstraintTop(subView: subView)
        }
    }
    
    
    /*! 坐标写死不改变高度 */
    func mg_autoLayoutWithFrameTop(subView:UIView) {
        var subFrame = subView.frame
        subFrame.origin.y += statusBarMargin
        subView.frame = subFrame
    }
    
    /*! 坐标写死改变高度 */
    func mg_autoLayoutWithFrameHeight(subView:UIView) {
        var subFrame = subView.frame
        subFrame.size.height += statusBarMargin
        subView.frame = subFrame
        mg_layoutWithTopSubView(superView: subView)
    }
    
    /*! 约束不改变高度 */
    func mg_autoLayoutWithConstraintTop(subView:UIView) {
        guard let superview = subView.superview else { return }
        superview.constraints.forEach { [weak subView](constraint) in
            guard let `subView` = subView else { return }
            if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                constraint.firstAttribute == .top  {
                constraint.constant += statusBarMargin
            }
            else if let secondView = constraint.secondItem as? UIView, secondView == subView &&
                constraint.secondAttribute == .top  {
                constraint.constant -= statusBarMargin
            }
        }
    }
    
    /*! 约束改变高度 */
    func mg_autoLayoutWithConstraintHeight(subView:UIView) {
        var isChangeHeight = false
        subView.constraints.forEach({ [weak subView] (constraint) in
            guard let `subView` = subView else { return }
            if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                constraint.firstAttribute == .height {
                constraint.constant += statusBarMargin
                isChangeHeight = true
            }
        })
        if isChangeHeight {
            subView.constraints.forEach({ [weak subView] (constraint) in
                guard let `subView` = subView else { return }
                if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                    constraint.firstAttribute == .top {
                    constraint.constant -= statusBarMargin
                }
                else if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                    constraint.firstAttribute == .centerY {
                    constraint.constant -= statusBarMargin/2
                }
                else if let secondView = constraint.secondItem as? UIView, secondView == subView &&
                    constraint.secondAttribute == .top {
                    constraint.constant += statusBarMargin
                }
                else if let secondView = constraint.secondItem as? UIView, secondView == subView &&
                    constraint.secondAttribute == .centerY {
                    constraint.constant += statusBarMargin/2
                }
            })
            mg_layoutWithTopSubView(superView: subView)
        }
    }
    
    func mg_layoutWithTopSubView(superView:UIView) {
        superView.subviews.forEach { (subView) in
            if !subView.isAutoLayout() {
                var subFrame = subView.frame
                subFrame.origin.y += statusBarMargin
                subView.frame = subFrame
            }
        }
    }
    
}
