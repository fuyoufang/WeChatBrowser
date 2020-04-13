//
//  TUIMessageDataProviderService.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/11.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class TUIMessageDataProviderService: TUIMessageDataProviderServiceProtocol {
    
    static let service = TUIMessageDataProviderService()
    
    private init() {
        
    }
    
    func getDisplayString(friendshipManager: TIMFriendshipManager, message: TIMMessage) -> String? {
        var str: String?
        if message.status == .LOCAL_REVOKED {
            if message.isSelf() {
                str = "你撤回了一条消息"
            } else if message.getConversation().getType() == .GROUP {
                var userString = message.getSenderGroupMemberProfile()?.nameCard
                if userString == nil || userString?.count == 0 {
                    if let userProfile = friendshipManager.queryUserProfile(message.sender()) {
                        userString = userProfile.showName(friendshipManager: friendshipManager)
                    }
                }
                str = "\"\(userString ?? "")\"撤回了一条消息"
            } else if message.getConversation().getType() == .C2C {
                str = "对方撤回了一条消息"
            }
        } else {
            for elem in message.elems {
                if let text = elem as? TIMTextElem {
                    str = text.text
                    break
                } else if let _ = elem as? TIMCustomElem {
                    //                    str = custom.ext
                    str = "自定义消息"
                    break
                } else if let _ = elem as? TIMImageElem {
                    str = "[语音]"
                    break
                } else if let _ = elem as? TIMSoundElem {
                    str = "[语音]"
                    break
                } else if let _ = elem as? TIMVideoElem {
                    str = "[视频]"
                    break
                } else if let _ = elem as? TIMFaceElem {
                    str = "[动画表情]"
                    break
                } else if let _ = elem as? TIMFileElem {
                    str = "[文件]"
                    break
                } else if let tips = elem as? TIMGroupTipsElem {
                    let opUser = getOpUser(fromTip: tips)
                    let userList = getUserList(fromTip: tips)
                    switch tips.type {
                    case .INVITE:
                        str = "INVITE"
                        //                        let userID = tips.userList?.joined(separator: "、")
                        
                        //                        NSString *users = [userList componentsJoinedByString:@"、"];
                        //                                    if ([tips.opUser isEqualToString:userID]) {
                        //                                        str = [NSString stringWithFormat:@"\"%@\"加入群组", opUser];
                        //                                    } else {
                        //                                        str = [NSString stringWithFormat:@"\"%@\"邀请\"%@\"加入群组", opUser, users];
                    //                                                 }
                    case .QUIT_GRP:
                        str = "QUIT_GRP"
                        //                        if (tips.opUser.length) {
                        //                                        str = [NSString stringWithFormat:@"\"%@\"退出了群聊", opUser];
                    //                                    }
                    case .KICKED:
                        str = "KICKED"
                        //                        NSString *users = [userList componentsJoinedByString:@"、"];
                    //                                    str = [NSString stringWithFormat:@"\"%@\"将\"%@\"踢出群组", opUser, users];
                    case .SET_ADMIN:
                        str = "SET_ADMIN"
                        //                        if (userList.count > 0) {
                        //                                        NSString *users = [userList componentsJoinedByString:@"、"];
                        //                                        str = [NSString stringWithFormat:@"\"%@\"被设置管理员", users];
                    //                                    }
                    case .CANCEL_ADMIN:
                        str = "CANCEL_ADMIN"
                        //                        if (userList.count > 0) {
                        //                                        NSString *users = [userList componentsJoinedByString:@"、"];
                        //                                        str = [NSString stringWithFormat:@"\"%@\"被取消管理员", users];
                    //                                    }
                    case .INFO_CHANGE:
                        str = "INFO_CHANGE"
                    case .MEMBER_INFO_CHANGE:
                        str = "MEMBER_INFO_CHANGE"
                        //                        str = [NSString stringWithFormat:@"\"%@\"", opUser];
                        //                                    for (TIMGroupTipsElemGroupInfo *info in tips.groupChangeList) {
                        //                                        switch (info.type) {
                        //                                            case TIM_GROUP_INFO_CHANGE_GROUP_NAME:
                        //                                            {
                        //                                                str = [NSString stringWithFormat:@"%@修改群名为\"%@\"、", str, info.value];
                        //                                            }
                        //                                                break;
                        //                                            case TIM_GROUP_INFO_CHANGE_GROUP_INTRODUCTION:
                        //                                            {
                        //                                                str = [NSString stringWithFormat:@"%@修改群简介为\"%@\"、", str, info.value];
                        //                                            }
                        //                                                break;
                        //                                            case TIM_GROUP_INFO_CHANGE_GROUP_NOTIFICATION:
                        //                                            {
                        //                                                str = [NSString stringWithFormat:@"%@修改群公告为\"%@\"、", str, info.value];
                        //                                            }
                        //                                                break;
                        //                                            case TIM_GROUP_INFO_CHANGE_GROUP_OWNER:
                        //                                            {
                        //                                                str = [NSString stringWithFormat:@"%@修改群主为\"%@\"、", str, info.value];
                        //                                            }
                        //                                                break;
                        //                                            case TIM_GROUP_INFO_CHANGE_GROUP_FACE:
                        //                                            {
                        //                                                str = [NSString stringWithFormat:@"%@修改群头像、", str];
                        //                                            }
                        //                                                break;
                        //                                            default:
                        //                                                break;
                        //                                        }
                        //                                    }
                        //                                    if (str.length > 0) {
                        //                                        str = [str substringToIndex:str.length - 1];
                        //                                    }
                        //
                    //                                }
                    @unknown default:
                        str = "default"
                    }
                    break
                } else if let tips = elem as? TIMGroupSystemElem {
                    // TODO: 退群消息由于SDK的bug，导致经常接收不到
                    // GroupSeystem的conv->groupId为空
                    switch (tips.type) {
                    case .DELETE_GROUP_TYPE:
                        str = "您所在的群已解散"
                    default:
                        break;
                    }
                }
            }
        }
        return str ?? ""
    }
    
    func getCellData(message: TIMMessage, fromElem elem: TIMElem) -> TUIMessageCellData? {
        return nil
    }
    
    func getTextCellData(message: TIMMessage, fromElem elem: TIMElem) -> TUITextMessageCellData? {
        return nil
    }
    
    static func singleton() -> Bool {
        return true
    }
    
    
    //    + (id)shareInstance
    //    {
    //        static TUIMessageDataProviderService *shareInstance;
    //        static dispatch_once_t onceToken;
    //        dispatch_once(&onceToken, ^{
    //            shareInstance = [[self alloc] init];
    //        });
    //        return shareInstance;
    //    }
    //
    
    //
    //    -(TUIMessageCellData *) getCellData:(TIMMessage *)message fromElem:(TIMElem *)elem{
    //        TUIMessageCellData *data = nil;
    //        if([elem isKindOfClass:[TIMTextElem class]]){
    //           data = [self getTextCellData:message fromElem:(TIMTextElem *)elem];
    //
    //        }else if([elem isKindOfClass:[TIMFaceElem class]]){
    //
    //            data = [self getFaceCellData:message fromElem:(TIMFaceElem *)elem];
    //
    //        }else if([elem isKindOfClass:[TIMImageElem class]]){
    //
    //            data = [self getImageCellData:message fromElem:(TIMImageElem *)elem];
    //
    //        }else if([elem isKindOfClass:[TIMSoundElem class]]){
    //
    //            data = [self getVoiceCellData:message fromElem:(TIMSoundElem *)elem];
    //
    //        }else if([elem isKindOfClass:[TIMVideoElem class]]){
    //
    //            data = [self getVideoCellData:message fromElem:(TIMVideoElem *)elem];
    //
    //        }else if([elem isKindOfClass:[TIMFileElem class]]){
    //
    //            data = [self getFileCellData:message fromElem:(TIMFileElem *)elem];
    //
    //        }else{
    //            data = [self getSystemCellData:message formElem:elem];
    //        }
    //        //赋值头像 URL，否则消息单元不回显示对方头像
    //        data.avatarUrl = [NSURL URLWithString:[[TIMFriendshipManager sharedInstance] queryUserProfile:message.sender].faceURL];
    //
    //        return data;
    //    }
    //
    //    - (TUITextMessageCellData *) getTextCellData:(TIMMessage *)message  fromElem:(TIMTextElem *)elem{
    //        TIMTextElem *text = (TIMTextElem *)elem;
    //        TUITextMessageCellData *textData = [[TUITextMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //        textData.content = text.text;
    //
    //
    //        return textData;
    //    }
    //
    //    - (TUIFaceMessageCellData *) getFaceCellData:(TIMMessage *)message  fromElem:(TIMFaceElem *)elem{
    //
    //        TIMFaceElem *face = (TIMFaceElem *)elem;
    //        TUIFaceMessageCellData *faceData = [[TUIFaceMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //        faceData.groupIndex = face.index;
    //        faceData.faceName = [[NSString alloc] initWithData:face.data encoding:NSUTF8StringEncoding];
    //        for (TFaceGroup *group in [TUIKit sharedInstance].config.faceGroups) {
    //            if(group.groupIndex == faceData.groupIndex){
    //                NSString *path = [group.groupPath stringByAppendingPathComponent:faceData.faceName];
    //                faceData.path = path;
    //                break;
    //            }
    //        }
    //        faceData.reuseId = TFaceMessageCell_ReuseId;
    //
    //        //如果没有查询到该表情，或者表情在本机无法解析，返回一个文字消息，提示无法解析。
    //        UIImage *image = [[TUIImageCache sharedInstance] getFaceFromCache:faceData.path];
    //        if(image == nil){
    //            TUITextMessageCellData *textData = [[TUITextMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //            textData.content = faceData.faceName;
    //            return textData;
    //        }
    //
    //
    //        return faceData;
    //    }
    //
    //    - (TUIImageMessageCellData *) getImageCellData:(TIMMessage *)message fromElem:(TIMImageElem *)elem{
    //        TIMImageElem *image = (TIMImageElem *)elem;
    //        TUIImageMessageCellData *imageData = [[TUIImageMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //        imageData.path = [image.path safePathString];
    //        imageData.items = [NSMutableArray array];
    //        for (TIMImage *item in image.imageList) {
    //            TUIImageItem *itemData = [[TUIImageItem alloc] init];
    //            itemData.uuid = item.uuid;
    //            itemData.size = CGSizeMake(item.width, item.height);
    //            itemData.url = item.url;
    //            if(item.type == TIM_IMAGE_TYPE_THUMB){
    //                itemData.type = TImage_Type_Thumb;
    //            }
    //            else if(item.type == TIM_IMAGE_TYPE_LARGE){
    //                itemData.type = TImage_Type_Large;
    //            }
    //            else if(item.type == TIM_IMAGE_TYPE_ORIGIN){
    //                itemData.type = TImage_Type_Origin;
    //            }
    //            [imageData.items addObject:itemData];
    //        }
    //        return imageData;
    //    }
    //
    //    - (TUIVoiceMessageCellData *) getVoiceCellData:(TIMMessage *) message fromElem:(TIMSoundElem *) elem{
    //        TIMSoundElem *sound = (TIMSoundElem *)elem;
    //        TUIVoiceMessageCellData *soundData = [[TUIVoiceMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //        soundData.duration = sound.second;
    //        soundData.length = sound.dataSize;
    //        soundData.uuid = sound.uuid;
    //
    //        return soundData;
    //    }
    //
    //    - (TUIVideoMessageCellData *) getVideoCellData:(TIMMessage *)message fromElem:(TIMVideoElem *) elem{
    //        TIMVideoElem *video = (TIMVideoElem *)elem;
    //        TUIVideoMessageCellData *videoData = [[TUIVideoMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //        videoData.videoPath = [video.videoPath safePathString];
    //        videoData.snapshotPath = [video.snapshotPath safePathString];
    //
    //        videoData.videoItem = [[TUIVideoItem alloc] init];
    //        videoData.videoItem.uuid = video.video.uuid;
    //        videoData.videoItem.type = video.video.type;
    //        videoData.videoItem.length = video.video.size;
    //        videoData.videoItem.duration = video.video.duration;
    //
    //        videoData.snapshotItem = [[TUISnapshotItem alloc] init];
    //        videoData.snapshotItem.uuid = video.snapshot.uuid;
    //        videoData.snapshotItem.type = video.snapshot.type;
    //        videoData.snapshotItem.length = video.snapshot.size;
    //        videoData.snapshotItem.size = CGSizeMake(video.snapshot.width, video.snapshot.height);
    //
    //        return videoData;
    //
    //    }
    //
    //    - (TUIFileMessageCellData *) getFileCellData:(TIMMessage *)message fromElem:(TIMFileElem *)elem{
    //        TIMFileElem *file = (TIMFileElem *)elem;
    //        TUIFileMessageCellData *fileData = [[TUIFileMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //        fileData.path = [file.path safePathString];
    //        fileData.fileName = file.filename;
    //        fileData.length = file.fileSize;
    //        fileData.uuid = file.uuid;
    //
    //        return fileData;
    //    }
    //
    //    - (TUISystemMessageCellData *) getSystemCellData:(TIMMessage *)message formElem:(TIMElem *)elem{
    //        if ([elem isKindOfClass:[TIMCustomElem class]]) {
    //            TIMCustomElem *custom = (TIMCustomElem *)elem;
    //
    //            //系统信息中，对创建群、邀请、提出、退群、撤回、修改群信息（公告昵称等）的用户名添加了触摸响应。
    //            //触摸响应通过 TUIJoinGroupMessageCell（继承自 TUISystemMessageCell）实现。
    //            //触摸用户名可以跳转到对应的用户信息界面。
    //
    //            if (custom.data.bytes) {
    //                if (strcmp(custom.data.bytes, "group_create") == 0) {
    //                    TIMUserProfile *userProfile = [[TIMFriendshipManager sharedInstance] queryUserProfile:message.sender];
    //                    TUIJoinGroupMessageCellData *joinGroupData = [[TUIJoinGroupMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //                    if (userProfile) {
    //                        [joinGroupData.userName addObject:userProfile.showName];
    //                        [joinGroupData.userID addObject:userProfile.identifier];
    //                    }
    //                    //此信息在刚刚创建群时显示，所以暂时不需要考虑群名片，因为此时群名片必定未设置。
    //                    joinGroupData.content = [self getDisplayString:message];
    //                    if(joinGroupData.userName.count && joinGroupData.userName.count == joinGroupData.userID.count){
    //                        return joinGroupData;
    //                    }
    //                }
    //            }
    //        } else if ([elem isKindOfClass:[TIMGroupTipsElem class]]){
    //            //对群信息小灰条特殊处理。
    //            TIMGroupTipsElem *tip = (TIMGroupTipsElem *)elem;
    //            NSString *opUser = [self getOpUserFromTip:tip];
    //            NSMutableArray<NSString *> *userList = [self getUserListFromTip:tip];
    //            if(tip.type == TIM_GROUP_TIPS_TYPE_INVITE){
    //                //入群与踢出不同，在入群时，opUser 可能和 user 为同一人。
    //                TUIJoinGroupMessageCellData *joinGroupData = [[TUIJoinGroupMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //                joinGroupData.content = [self getDisplayString:message];
    //                [joinGroupData.userName addObject:opUser];
    //                [joinGroupData.userID addObject:tip.opUser];
    //                if(userList.count && ![tip.opUser isEqualToString:tip.userList[0]]){//此处加入判定，如果是自主入群，即 opUser和userlist相同 则不再重复添加 userList 信息。
    //                    [joinGroupData.userName addObjectsFromArray:userList];//多人入群的昵称
    //                    [joinGroupData.userID addObjectsFromArray:tip.userList];//多人入群的ID，用于跳转到用户界面。
    //                }
    //                if(joinGroupData.userName.count && joinGroupData.userName.count == joinGroupData.userID.count){
    //                return joinGroupData;
    //                }
    //
    //            } else if(tip.type == TIM_GROUP_TIPS_TYPE_KICKED){
    //                TUIJoinGroupMessageCellData *joinGroupData = [[TUIJoinGroupMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //                joinGroupData.content = [self getDisplayString:message];
    //                [joinGroupData.userName addObject:opUser];
    //                [joinGroupData.userID addObject:tip.opUser];
    //                if(userList.count){
    //                    [joinGroupData.userName addObjectsFromArray:userList];//多人入群的昵称
    //                    [joinGroupData.userID addObjectsFromArray:tip.userList];//多人入群的ID，用于跳转到用户界面。
    //                }
    //                if(joinGroupData.userName.count && joinGroupData.userName.count == joinGroupData.userID.count){
    //                    return joinGroupData;
    //                }
    //            } else if(tip.type == TIM_GROUP_TIPS_TYPE_INFO_CHANGE){
    //                TUIJoinGroupMessageCellData *joinGroupData = [[TUIJoinGroupMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //                joinGroupData.content = [self getDisplayString:message];
    //                [joinGroupData.userName addObject:opUser];
    //                [joinGroupData.userID addObject:tip.opUser];
    //                if(joinGroupData.userName.count && joinGroupData.userName.count == joinGroupData.userID.count){
    //                    return joinGroupData;
    //                }
    //            }else if(tip.type == TIM_GROUP_TIPS_TYPE_QUIT_GRP){
    //                TUIJoinGroupMessageCellData *joinGroupData = [[TUIJoinGroupMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //                joinGroupData.content = [self getDisplayString:message];
    //                [joinGroupData.userName addObject:opUser];
    //                [joinGroupData.userID addObject:tip.opUser];
    //                if(joinGroupData.userName.count && joinGroupData.userName.count == joinGroupData.userID.count){
    //                    return joinGroupData;
    //                }
    //            }
    //            else{
    //            //其他群Tips消息正常处理
    //                TUISystemMessageCellData *sysdata = [[TUISystemMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //                sysdata.content = [self getDisplayString:message];
    //                if (sysdata.content.length) {
    //                    return sysdata;
    //                }
    //            }
    //
    //        }else {
    //            //其他系统消息正常处理
    //            TUISystemMessageCellData *sysdata = [[TUISystemMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //            sysdata.content = [self getDisplayString:message];
    //            if (sysdata.content.length) {
    //                return sysdata;
    //            }
    //        }
    //        return nil;
    //    }
    //
    //    - (TUISystemMessageCellData *) getRevokeCellData:(TIMMessage *)message{
    //
    //        TUISystemMessageCellData *revoke = [[TUISystemMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    //
    //        //此处若根据 message.Status 返回撤回字符串的话，会在 messageController 的 onRevoke 回调时发生错误，因为回调函数为异步，执行至此处时 status 还未更改，导致返回错误结果。若强行等待/同步可能造成更大问题。
    //        //所以此处将 getDisplayString 中的处理逻辑复制到此处。在今后更改撤回消息的逻辑时，注意要在此处和 getDisplayString 中同步更改。
    //        //TODO 在今后发现更好的解决方案时，进一步在此优化。
    //        //revoke.content = [self getDisplayString:message];
    //        if ([[message getConversation] getType] == TIM_GROUP) {
    //            //对于群组消息的名称显示，优先显示群名片，昵称优先级其次，用户ID优先级最低。
    //            NSString *userString = [message getSenderGroupMemberProfile].nameCard;;
    //            if(userString == nil || userString.length == 0){
    //                TIMUserProfile *userProfile = [[TIMFriendshipManager sharedInstance] queryUserProfile:message.sender];
    //                if (userProfile) {
    //                    userString = userProfile.showName;
    //                } else {
    //                    userString = message.sender;
    //                }
    //            }
    //            TUIJoinGroupMessageCellData *joinGroupData = [[TUIJoinGroupMessageCellData alloc] initWithDirection:MsgDirectionIncoming];
    //            joinGroupData.content = [NSString stringWithFormat:@"\"%@\"撤回了一条消息", userString];
    //            [joinGroupData.userName addObject:userString];
    //            [joinGroupData.userID addObject:message.sender];
    //            if(joinGroupData.userName.count && joinGroupData.userName.count == joinGroupData.userID.count){
    //                return joinGroupData;
    //            }
    //        }
    //
    //
    //
    //        if(message.isSelf){
    //            revoke.content = @"你撤回了一条消息";
    //        }
    //        else if ([[message getConversation] getType] == TIM_C2C){
    //            revoke.content = @"对方撤回了一条消息";
    //        }
    //
    //        revoke.innerMessage = message;
    //
    //        return revoke;
    //
    //    }
    func getOpUser(fromTip tip: TIMGroupTipsElem) -> String? {
        if let nameCard = tip.opGroupMemberInfo?.nameCard, !nameCard.isEmpty {
            return nameCard
        }
        
        if let nickname = tip.opUserInfo?.nickname, !nickname.isEmpty {
            return nickname
        }
        
        return tip.opUser
    }
    
    func getUserList(fromTip tip: TIMGroupTipsElem) -> [String] {
        guard let tipUsers = tip.userList else {
            return []
        }
        
        var userList = [String]()
        for userID in tipUsers {
            let nameCard = tip.changedGroupMemberInfo[userID]?.nameCard
            if !(nameCard?.isEmpty ?? true) {
                userList.append(nameCard!)
                continue
            }
            
            let nickName = tip.changedUserInfo[userID]?.nickname
            if !(nickName?.isEmpty ?? true) {
                userList.append(nickName!)
                continue
            }
            
            userList.append(userID)
        }
        
        return userList
    }
    
}
