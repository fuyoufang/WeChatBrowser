//
//  TIMUserProfile+DataProvider.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

extension TIMUserProfile {
    var expr: TUIUserProfileDataProviderServiceProtocol {
        get {
           return TCServiceManager
            .shareInstance()
            .userProfileDataProviderService
        }
    }
    
    func showName(friendshipManager: TIMFriendshipManager) -> String? {
        return expr.getName(friendshipManager: friendshipManager, profile: self)
    }
    
    func showGender() -> String? {
        return expr.getGender(profile: self)
    }
    
    func showSignature() -> String? {
        return expr.getSignature(profile: self)
    }
    
    func showLocation() -> String? {
        return expr.getLocation(profile: self)
    }
    
    func showBirthday() -> Date? {
        return expr.getBirthday(profile: self)
    }
    
    func showAllowType() -> String? {
        return expr.getAllowType(profile: self)
    }
    
    //- (void)setShowBirthday:(NSDate *)date
    //{
    //    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    //
    //    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags fromDate:date];
    //
    //    self.birthday = (uint32_t)(dateComponents.year * 10000 + dateComponents.month * 100 + dateComponents.day);
    //}
    
    func avatarView() -> NSImageView? {
        return expr.getAvatarView(profile: self)
    }
    
}
