//
//  TIMManager+MsgExt.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

/**
 * IMSDK 扩展类，此处主要存放待废弃的 API 函数，建议您使用 TIMManager.h 内部声明的接口函数
 */
//(MsgExt)
extension TIMManager {

/**
 *  获取群管理器
 *
 *  此函数待废弃，请直接使用 TIMGroupManager 的 sharedInstance 函数
 *
 *  @return 群管理器，详情请参考 TIMGroupManager.h 中的 TIMGroupManager 定义
 */
    func groupManager() -> TIMGroupManager? {
        fatalError()
    }


/**
 *  获取好友管理器
 *
 *  此函数待废弃，请直接使用 TIMFriendshipManager 的 sharedInstance 函数
 *
 *  @return 好友管理器，详情请参考 TIMFriendshipManager.h 中的 TIMFriendshipManager 定义
 */
    func friendshipManager() -> TIMFriendshipManager? {
        fatalError()
    }

/**
 *  获取会话数量
 *
 *  @return 会话数量
 */
    func conversationCount() -> Int {
        fatalError()
    }

}
