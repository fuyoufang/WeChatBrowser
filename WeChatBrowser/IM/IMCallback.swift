//
//  IMCallback.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

/**
 *  连接通知回调
 */
protocol TIMConnListener {
    /**
     *  网络连接成功
     */
    func onConnSucc()

    /**
     *  网络连接失败
     *
     *  @param code 错误码
     *  @param err  错误描述
     */
    func onConnFailed(code: Int, err: String?)
    /**
     *  网络连接断开（断线只是通知用户，不需要重新登录，重连以后会自动上线）
     *
     *  @param code 错误码
     *  @param err  错误描述
     */
    func onDisconnect(code: Int, err: String?)

    /**
     *  连接中
     */
    func onConnecting()

}

extension TIMConnListener {
    func onConnSucc() {}

    func onConnFailed(code: Int, err: String?) {}
    
    func onDisconnect(code: Int, err: String?) {}

    func onConnecting() {}
}


/**
 *  页面刷新接口（如有需要未读计数刷新，会话列表刷新等）
 */
protocol TIMRefreshListener {

/**
 *  刷新会话
 */
func onRefresh()

/**
 *  刷新部分会话
 *
 *  @param conversations 会话（TIMConversation*）列表
 */
func onRefresh(conversations: [TIMConversation])
}


