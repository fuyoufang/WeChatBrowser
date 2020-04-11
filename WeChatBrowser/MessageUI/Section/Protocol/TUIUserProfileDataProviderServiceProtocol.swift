//
//  TUIUserProfileDataProviderServiceProtocol.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

protocol TUIUserProfileDataProviderServiceProtocol: TCServiceProtocol {
    
    // MARK: - TIMUserProfile
    
    /**
     *  获取用户姓名。
     *  如果当前信息对应的用户是好友的话，则通过 TIMFriendshipManager 提供的 queryFriend 接口获取好友，并进一步获取备注。
     *  如果当前信息对应的用户不是好友，则返回传入信息中的用户 ID。
     *
     *  @return 返回的用户昵称。好友默认返回备注，当好友未设置备注或者为陌生人时返回用户 ID。
     */
//    func getName(profile: TIMUserProfile) -> String?
    func getName(friendshipManager: TIMFriendshipManager, profile: TIMUserProfile) -> String?
    /**
     *  获取用户的性别。
     *
     *  @param profile 传入的用户资料。从该资料中获取特定的信息。
     *
     *  @return 以字符串形式返回用户性别。“男”/“女”/“未知”。
     */
    func getGender(profile: TIMUserProfile) -> String?
    /**
     *  获取用户签名。
     *
     *  @param profile 传入的用户资料。从该资料中获取特定的信息。
     *
     *  @return 以字符串形式返回用户签名。
     */
    func getSignature(profile: TIMUserProfile) -> String?
    
    /**
     *  获取用户所在地。
     *
     *  @param profile 传入的用户资料。从该资料中获取特定的信息。
     *
     *  @return 以字符串形式返回用户所在地。
     */
    func getLocation(profile: TIMUserProfile) -> String?
    
    /**
     *  获取用户生日
     *
     *  @param profile 传入的用户资料。从该资料中获取特定的信息。
     *
     *  @return 返回用户的生日。
     */
    func getBirthday(profile: TIMUserProfile) -> Date?
    
    /**
     *  获取用户的添加要求。用于在用户信息页面显示。
     *
     *  @param profile 传入的用户资料。从该资料中获取特定的信息。
     *
     *  @return 以字符串形式返回。 "同意任何用户加好友" / "需要验证" / "需要验证"。
     */
    func getAllowType(profile: TIMUserProfile) -> String?
    
    /**
     *  获取用户头像
     *  profile 中含有用户头像的 URL，我们通过 URL 获取头像并包装为 UIImageView 后返回。
     *
     *  @param profile 传入的用户资料。从该资料中获取特定的信息。
     *
     *  @return 将获取到的图像包装为 UIImageView 后返回。
     */
    func getAvatarView(profile: TIMUserProfile) -> NSImageView?
}
