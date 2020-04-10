//
//  TUIKit.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class TUIKit {

/**
 *  共享实例
 *  TUIKit为单例
 */
    static let kit = TUIKit()
    private init() {
        
    }
    static func sharedInstance() -> TUIKit {
        return kit
    }

/**
 *  TUIKit配置类，包含默认表情、默认图标资源等
 */
    let config = TUIKitConfig()
}


