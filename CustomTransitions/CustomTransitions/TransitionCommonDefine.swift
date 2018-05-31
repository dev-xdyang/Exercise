//
//  NormalTransitionCommonDefine.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

public enum Direction {
    case toLeft
    case toRight
    case toTop
    case toBottom
}

// MARK: - Direction match
extension UIPanGestureRecognizer {
    public func isMatch(direction: Direction) -> Bool {
        guard let targetView = self.view else { return false }
        let velocityValue = velocity(in: targetView)
        switch direction {
        case .toLeft:
            return velocityValue.x < 0
        case .toRight:
            return velocityValue.x > 0
        case .toTop:
            return velocityValue.y < 0
        case .toBottom:
            return velocityValue.y > 0
        }
    }
}

public enum AnimatorType {
    case dissolve
    case halfWaySpring
}
