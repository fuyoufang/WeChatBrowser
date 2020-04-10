//
//  IMManager.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
/////////////////////////////////////////////////////////////////////
//
//                     腾讯云通信服务 IMSDK
//
//  模块名称：TIMManager
//
//  模块功能：IMSDK 主核心模块，负责 IMSDK 的初始化、登录、创建会话、管理推送等功能。
//
//  (1) 初始化：初始化是使用 TIMSDK 的前提，任何其它 API 的调用都应该在 initSdk 接口之后被调用。
//
//  (2) 登录：需要设置 SDKAppID，userID 和 userSig 才能使用腾讯云服务。
//
//  (3) 会话：一个会话对应一个聊天窗口，比如跟一个好友的 C2C 聊天，或者一个聊天群，都是一个会话。
//
//  (4) 推送：管理和设置 APNS 的相关功能，包括 token 和开关等。
//
/////////////////////////////////////////////////////////////////////


/**
 * IMSDK 主核心类，负责 IMSDK 的初始化、登录、创建会话、管理推送等功能。
 */
class TIMManager {

// MARK: 一，初始化相关接口函数

/////////////////////////////////////////////////////////////////////////////////
//
//                      （一）初始化相关接口函数
//
/////////////////////////////////////////////////////////////////////////////////

/// @name 初始化相关接口
/// @{
/**
 *  1.1 获取管理器实例 TIMManager
 *
 *  @return 管理器实例
 */
    
    private static let manager = TIMManager()
    private init() {
        
    }
    
    static func sharedInstance() -> TIMManager {
        return manager
    }


// MARK: 三，会话管理器
/////////////////////////////////////////////////////////////////////////////////
//
//                      （三）会话管理器
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 会话管理器
/// @{

/**
 *  3.1 获取会话列表
 *
 *  一个会话对应一个聊天窗口，比如跟一个好友的 1v1 聊天，或者一个聊天群，都是一个会话。
 *
 *  @return 会话列表
 */
    func getConversationList() -> [TIMConversation] {
        fatalError()
    }

/**
 *  3.2 获取单个会话
 *
 *  TIMConversation 负责会话相关操作，包含发送消息、获取会话消息缓存、获取未读计数等。
 *
 *  @param type 详情请参考 TIMComm.h 里面的 TIMConversationType 定义
 *  @param conversationId 会话 ID
                          单聊类型（C2C）   ：为对方 userID；
                          群组类型（GROUP） ：为群组 groupId；
                          系统类型（SYSTEM）：为 @""
 *
 *  @return 会话对象，详情请参考 TIMConversation.h 里面的 TIMConversation 定义
 */
    func getConversation(type: TIMConversationType, conversationId: String) -> TIMConversation? {
        fatalError()
    }
}

