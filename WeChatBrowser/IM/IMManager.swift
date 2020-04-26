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
    private let weChatManager: MessageManager
    private(set) lazy var lastLoginUser: IMUser? = getLastLoginUser()
    private let localInfoPath: String
    
    private let filePath: String
    init(filePath: String) {
        self.filePath = filePath
        self.weChatManager = MessageManager(appPath: filePath)
        self.localInfoPath = "\(filePath)/Documents/LocalInfo.lst"
        
    }
    
    // MARK: 登录用户
    private var _userManagerList: [TIMUserManager]?
    var userManagerList: [TIMUserManager] {
        get {
            if _userManagerList == nil {
                _userManagerList = getUserManagerList()
            }
            return _userManagerList!
        }
    }
    
    private func getUserManagerList() -> [TIMUserManager] {
        let fileNames = weChatManager.userDataFileNames
        return fileNames.compactMap { (fileName) -> TIMUserManager? in
            guard let userData = weChatManager.getData(userNameMD5: fileName) else {
                return nil
            }
            let user: IMUser
            if lastLoginUser != nil, lastLoginUser?.userNameMD5 == fileName {
                user = lastLoginUser!
            } else {
                user = IMUser(userNameMD5: fileName)
            }
            
            return TIMUserManager(userData: userData, user: user)
        }
    }
    
    private func getLastLoginUser() -> IMUser? {
        guard FileManager.default.fileExists(atPath: localInfoPath) else {
            return nil
        }
        guard let dic = NSDictionary(contentsOfFile: localInfoPath),
            let objects = dic["$objects"] as? [Any] else {
            return nil
        }
        
        debugPrint(dic)
        
        var user = IMUser()
        for (index, item) in objects.enumerated() {
            if index == 2, let userName = item as? String {
                user.userName = userName
            } else if index == 3, let phoneName = item as? String {
                user.phoneName = phoneName
            } else if index == 4, let nickName = item as? String {
                user.nickName = nickName
            } else if index == 5, let v = item as? Dictionary<String, Any> {
                debugPrint(v)
            } else if index == 7, let v = item as? Data {
                debugPrint(v)
            } else if index == 9, let v = item as? Data {
                debugPrint(v)
            } else if index == 10, let phone = item as? String {
                user.phone = phone
            }
        }
        user.userNameMD5 = user.userName?.MD5()
        return user

    }
    
}

