//
//  MGAutoLayoutX.swift
//  Tex
//
//  Created by song on 2017/10/19.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit

/*! 判断iphone-X */
public var isIphone_X:Bool = (UIScreen.main.bounds.height == 812)

public var statusBarMargin:CGFloat = isIphone_X ? 24.0:0.0


public class MGAutoLayoutWithX: NSObject {
    
    fileprivate static let runOne:Void = {
        UIViewController.mgawake()
    }()
    
    public static let shared:MGAutoLayoutWithX = MGAutoLayoutWithX()
    
    public var isAutoLayout:Bool = true {
        didSet{
            if isAutoLayout && isIphone_X {
                MGAutoLayoutWithX.runOne
            }
        }
    }
}
