//
//  NormalTransitionCommonDefine.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

public enum PanDirection {
    case toLeft
    case toRight
    case toTop
    case toBottom
    
    public var toggle: PanDirection {
        switch self {
        case .toLeft:
            return .toRight
        case .toRight:
            return .toLeft
        case .toTop:
            return .toBottom
        case .toBottom:
            return .toTop
        }
    }
}

// MARK: - PanDirection match
extension UIPanGestureRecognizer {
    public func isMatch(direction: PanDirection) -> Bool {
        guard let targetView = self.view else { return false }
        let velocityValue = velocity(in: targetView)
        switch direction {
        case .toLeft:
            return velocityValue.x < 0 && abs(velocityValue.y) < 250
        case .toRight:
            return velocityValue.x > 0 && abs(velocityValue.y) < 250
        case .toTop:
            return velocityValue.y < 0 && abs(velocityValue.x) < 250
        case .toBottom:
            return velocityValue.y > 0 && abs(velocityValue.x) < 250
        }
    }
}

public enum AnimatorType {
    case dissolve
    case halfWaySpring
}
