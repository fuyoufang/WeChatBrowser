//
//  TUIUserProfileDataProviderService.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

final class TUIUserProfileDataProviderService: TUIUserProfileDataProviderServiceProtocol {
    
    static let shareInstance = TUIUserProfileDataProviderService()
        
    private init() { }
    
    func getName(profile: TIMUserProfile) -> String? {
        
        if let identifier = profile.identifier,
            let fd: TIMFriend = TIMFriendshipManager.sharedInstance().queryFriend(identifier: identifier),
            let remark = fd.remark,
            !remark.isEmpty  {
            return remark
        } else {
            if let nickname = profile.nickname, !nickname.isEmpty {
                return nickname
            } else {
                return profile.identifier;
            }
        }
    }
    
    func getGender(profile: TIMUserProfile) -> String? {
        switch profile.gender {
        case .MALE:
            return "男"
        case .FEMALE:
            return "女"
        default:
            return "未设置"
        }
    }
    
    func getSignature(profile: TIMUserProfile) -> String? {
        fatalError()
//        if (profile.selfSignature == nil)
//            return nil;
//
//        char *ch = malloc(profile.selfSignature.length+1);
//        [profile.selfSignature getBytes:ch];
//        ch[profile.selfSignature.length] = 0;
//        NSString *value = [NSString stringWithUTF8String:profile.selfSignature.bytes];
//        free(ch);
//        return value;
    }
    
    func getLocation(profile: TIMUserProfile) -> String? {
        fatalError()
        //    if(profile.location == nil){
        //        return @"未设置";
        //    }
        //    char *ch = malloc(profile.location.length+1);
        //    [profile.location getBytes:ch];
        //    ch[profile.location.length] = 0;
        //    NSString *value = [NSString stringWithUTF8String:profile.location.bytes];
        //    free(ch);
        //
        //    if([value isEqualToString:@""]){
        //        return @"未设置";
        //    }else   return value;
    }
    
    func getBirthday(profile: TIMUserProfile) -> Date? {
        fatalError()
        //    if (profile.birthday == 0)
        //        return nil;
        //
        //    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        //    dateComponents.day = profile.birthday % 100;
        //    dateComponents.month = (profile.birthday / 100) % 100;
        //    dateComponents.year = (profile.birthday / 10000) % 10000;
        //
        //    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        //    NSDate *date = [gregorianCalendar dateFromComponents:dateComponents];
        //
        //    return date;
    }
    
    func getAllowType(profile: TIMUserProfile) -> String? {
        fatalError()
//        if (profile.allowType == TIM_FRIEND_ALLOW_ANY) {
//            return @"同意任何用户加好友";
//        }
//        if (profile.allowType == TIM_FRIEND_NEED_CONFIRM) {
//            return @"需要验证";
//        }
//        if (profile.allowType == TIM_FRIEND_DENY_ANY) {
//            return @"拒绝任何人加好友";
//        }
//        return nil;
    }
    
    func getAvatarView(profile: TIMUserProfile) -> NSImageView? {
        fatalError()
        //    UIImageView *avatarView = [[UIImageView alloc] init];
        //
        //    [avatarView sd_setImageWithURL:[NSURL URLWithString:profile.faceURL] placeholderImage:DefaultAvatarImage];
        //
        //    return avatarView;
    }
    
    static func singleton() -> Bool {
        return true
    }
    
    
}

