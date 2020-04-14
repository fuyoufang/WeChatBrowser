//
//  NSView+Layout.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
extension NSView {
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: x + width / 2, y: y + height / 2)
        }
        set {
            x = newValue.x - width / 2
            y = newValue.y - height / 2
        }
    }
    
    var maxX: CGFloat {
        get {
            return x + width
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            x = (self.superview?.width ?? 0) - width - newValue
        }
    }
}

