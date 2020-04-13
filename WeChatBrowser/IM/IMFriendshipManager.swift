//
//  TIMFriendshipManager.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
import WCDBSwift

class TIMFriendshipManager {
    
    var _friends: [TIMFriend]?
    var friends: [TIMFriend] {
        get {
            if _friends == nil {
                _friends = getFriendList()
            }
            return _friends!
        }
    }
    
    var _friendDBs: [FriendDB]?
    public var friendDBs: [FriendDB] {
        get {
            if _friendDBs == nil {
                _friendDBs = getFriendDBs()
            }
            return _friendDBs!
        }
    }
    
    /**
     *  获取好友管理器实例
     *
     *  @return 管理器实例
     */
    let contactDatabase: Database
    init(contactDatabase: Database) {
        self.contactDatabase = contactDatabase
    }
    
    /**
     *  在缓存中查询自己的资料
     *
     *  @return 返回缓存的资料，未找到返回nil
     */
    func querySelfProfile() -> TIMUserProfile? {
        fatalError()
    }
    
    /**
     *  获取指定用户资料
     *
     *  @param identifiers 用户id，非好友的用户也可以
     *  @prarm forceUpdate 强制从后台拉取
     *  @param succ 成功回调
     *  @param fail 失败回调
     *
     *  @return 0 发送请求成功
     */
    func getUsersProfile(identifiers: [String], forceUpdate: Bool, succ: TIMUserProfileArraySucc, fail: TIMFail) -> Bool {
        fatalError()
    }
    
    /**
     *  在缓存中查询用户的资料
     *
     *  @praram identifier 用户id，非好友的用户也可以
     *
     *  @return 返回缓存的资料，未找到返回nil
     */
    func queryUserProfile(_ identifier: String) -> TIMUserProfile? {
        return friends.first { (friend) -> Bool in
            return friend.identifier == identifier
        }?.profile
    }
    
    private func getFriendDBs() -> [FriendDB] {
        do {
            let friendDBs: [FriendDB] = try self.contactDatabase.getObjects(fromTable: FriendTable)
            return friendDBs
        } catch let e {
            debugPrint(e)
        }
        return []
    }
    
    /**
     *  在缓存中查询用户的关系链数据
     *
     *  @praram identifier 用户id
     *
     *  @return 返回缓存的关系链数据，未找到返回nil
     *  @note 缓存数据来自于上一次调用getFriendList，请确保已调用了获取好友列表方法
     */
    func queryFriend(identifier: String) -> TIMFriend? {
        return friends.first { (item) -> Bool in
            return item.identifier == identifier
        }
    }
    
    /**
     *  获取缓存中的关系链列表
     *
     *  @return 返回缓存的关系链数据
     *  @note 缓存数据来自于上一次调用getFriendList，请确保已调用了获取好友列表方法
     */
    private func getFriendList() -> [TIMFriend] {
        return friendDBs.compactMap { (friendDB) -> TIMFriend? in
            guard let userName = friendDB.userName, !userName.hasSuffix("@chatroom") else {
                return nil
            }
            
            let friend = TIMFriend(friendDB: friendDB)
            return friend
        }
    }
    
    /**
     *  检查指定用户的好友关系
     *
     *  @param checkInfo 好友检查信息
     *  @param succ  成功回调，返回检查结果
     *  @param fail  失败回调
     *
     *  @return 0：发送成功；-1：checkInfo->users 参数异常；-2：checkInfo->checkType 参数异常
     */
    func checkFriends(checkInfo: TIMFriendCheckInfo, succ: TIMCheckFriendResultArraySucc, fail: TIMFail) -> Bool {
        fatalError()
    }
    
    
    /**
     *  未决已读上报
     *
     *  @param timestamp 已读时间戳，此时间戳以前的消息都将置为已读
     *  @param succ  成功回调
     *  @param fail  失败回调
     *
     *  @return 0 发送请求成功
     */
    func pendencyReport(timestamp: UInt64, succ: TIMSucc, fail: TIMFail) -> Bool {
        fatalError()
    }
    
    /**
     *  获取黑名单列表
     *
     *  @param succ 成功回调，返回NSString*列表
     *  @param fail 失败回调
     *
     *  @return 0 发送请求成功
     */
    func getBlackList(succ: TIMFriendArraySucc, fail: TIMFail) -> Bool {
        fatalError()
    }
    
    /**
     *  获取指定的好友分组信息
     *
     *  @param groupNames      要获取信息的好友分组名称列表,传入nil获得所有分组信息
     *  @param succ  成功回调，返回 TIMFriendGroup* 列表
     *  @param fail  失败回调
     *
     *  @return 0 发送请求成功
     */
    func getFriendGroups(groupNames: [String], succ: TIMFriendGroupArraySucc, fail: TIMFail) -> Bool {
        fatalError()
    }
}

