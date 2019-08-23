//
//  CTPaddedButton.swift
//  UIPageController
//
//  Created by Stewart Lynch on 2019-06-26.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import UIKit


public class CTPaddedButton: UIButton {
    public var padding:CGFloat = 10
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public class func newButton() -> CTPaddedButton {
        return CTPaddedButton.init(type: .system)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerArea:CGRect = .init(x: bounds.origin.x - padding,
                                      y: bounds.origin.y - padding,
                                      width: bounds.size.width + 2 * padding,
                                      height: bounds.size.height + 2 * padding)
        return largerArea.contains(point)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
