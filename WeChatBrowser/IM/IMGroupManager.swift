//
//  IMGroupManager.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class TIMGroupManager {

// MARK: 一，获取群组实例
/////////////////////////////////////////////////////////////////////////////////
//
//                      （一）获取群组实例
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 获取群组实例
/// @{
/**
 *  1.1 获取群管理器实例
 *
 *  @return 管理器实例
 */
   
    private static let manager = TIMGroupManager()
    static func sharedInstance() -> TIMGroupManager {
        return manager
    }
    
    private init() {
        
    }

// MARK: 四，获取群信息
/////////////////////////////////////////////////////////////////////////////////
//
//                      （四）获取群信息
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 获取群信息
/// @{

/**
 *  4.1 获取群列表
 *
 *  获取自己所加入的群列表。
 *
 *  @param succ 成功回调，NSArray 列表为 TIMGroupInfo，结构体只包含 group|groupName|groupType|faceUrl|allShutup|selfInfo 信息
 *  @param fail 失败回调
 *
 *  @return 0：成功；1：失败
 */
    func getGroupList(succ: TIMGroupListSucc, fail: TIMFail) -> Bool {
        fatalError()
    }
/**
 *  4.2 获取服务器存储的群组信息
 *
 *  1. 无论是公开群还是私有群，群成员均可以拉到群组信息。
 *  2. 如果是公开群，非群组成员可以拉到 group|groupName|owner|groupType|createTime|maxMemberNum|memberNum|introduction|faceURL|addOpt|onlineMemberNum|customInfo 这些字段信息。如果是私有群，非群组成员拉取不到群组信息。
 *
 *  @param succ 成功回调，NSArray 列表为 TIMGroupInfoResult,不包含 selfInfo 信息
 *  @param fail 失败回调
 *
 *  @return 0：成功；1：失败
 */
    func getGroupInfo(groups: [String], succ: TIMGroupListSucc, fail: TIMFail) -> Bool {
        fatalError()
    }

/**
 *  4.3 获取本地存储的群组信息
 *
 *  1. 无论是公开群还是私有群，群成员均可以拉到群组信息。
 *  2. 如果是公开群，非群组成员可以拉到 group|groupName|owner|groupType|createTime|maxMemberNum|memberNum|introduction|faceURL|addOpt|onlineMemberNum|customInfo 这些字段信息。如果是私有群，非群组成员拉取不到群组信息。
 *
 *  @param groupId 群组Id
 *
 *  @return 群组信息
 */
    func queryGroupInfo(groupId: String) -> TIMGroupInfo? {
        fatalError()
    }

/**
 *  4.4 获取群成员列表
 *
 *  @param groupId 群组Id
 *  @param succ    成功回调 (TIMGroupMemberInfo 列表)
 *  @param fail    失败回调
 *
 *  @return 0：成功；1：失败
 */
    func getGroupMembers(groupId: String, succ: TIMGroupMemberSucc, fail: TIMFail) {
        fatalError()
    }

/**
 *  4.5 获取本人在群组内的成员信息
 *
 *  @param groupId 群组Id
 *  @param succ    成功回调，返回信息
 *  @param fail    失败回调
 *
 *  @return 0：成功；1：失败
 */
    func getGroupSelfInfo(groupId: String, succ: TIMGroupSelfSucc, fail: TIMFail) -> Bool {
        fatalError()
    }
/**
 *  4.6 获取群组指定成员的信息
 *
 *  获取群组指定成员的信息，需要设置群成员 members，其他限制参考 getGroupMembers
 *
 *  @param groupId 群组Id
 *  @param members 成员Id（NSString*）列表
 *  @param succ    成功回调 (TIMGroupMemberInfo 列表)
 *  @param fail    失败回调
 *
 *  @return 0：成功；1：失败
 */
 
    func getGroupMembersInfo(groupId: String, members: [String], succ: TIMGroupMemberSucc, fail: TIMFail) -> Bool {
        fatalError()
    }

/**
 *  4.8 获取接受消息选项
 *
 *  @param groupId  群组Id
 *  @param succ     成功回调, TIMGroupReceiveMessageOpt 0：接收消息；1：不接收消息，服务器不进行转发；2：接受消息，不进行 iOS APNs 推送
 *  @param fail     失败回调
 *
 *  @return 0：成功；1：失败
 */
    func getReciveMessageOpt(groupId: String, succ: TIMGroupReciveMessageOptSucc, fail: TIMFail) -> Bool {
        fatalError()
    }
}

