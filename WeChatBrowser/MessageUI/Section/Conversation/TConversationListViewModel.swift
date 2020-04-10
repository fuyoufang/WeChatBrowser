//
//  TConversationListViewModel.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

typealias ConversationListFilterBlock = (_ data: TUIConversationCellData) -> Bool

class TConversationListViewModel {

    // MARK: Properies
    
    var isLoadFinished = false
    var isLoading = false
    var missC2CIds = [String : Any]()
    var missGroupIds = [String : Any]()
    //        self.missC2CIds = [[NSMapTable alloc] init];
    //        self.missGroupIds = [[NSMapTable alloc] init];
    
    /**
     * 会话数据
     */
    var dataList = [TUIConversationCellData]()
    /**
     * 过滤器
     */
    var listFilter: ConversationListFilterBlock?

    init() {
        loadConversation()
    }

    func cellDataOf(convId: String) -> TUIConversationCellData? {
        for data: TUIConversationCellData in self.dataList {
            if data.convId == convId {
                return data
            }
        }
        return nil
    }

    /**
    * 加载会话数据
    */
    func loadConversation() {
        let convs = TIMManager.sharedInstance().getConversationList()
        update(conversation: convs)
    }

    func update(conversation convs: [TIMConversation]) {
        var dataList = self.dataList
        for conv in convs {
            let data = TUIConversationCellData()
            let convId = conv.getReceiver()
            data.convId = convId
            data.convType = conv.getType()
            data.subTitle = getLastDisplayString(conv)
            data.time = getLastDisplayDate(conv)

            guard data.subTitle != nil && data.time != nil else {
                // 清理无效的记录
                let index = dataList.firstIndex { (item) -> Bool in
                    return item.convId == convId
                }
                if index != nil {
                    dataList.remove(at: index!)
                }
                continue;
            }

            if data.convType == .C2C {
                if let user: TIMUserProfile = TIMFriendshipManager.sharedInstance().queryUserProfile(convId) {
                    data.title = user.showName()
                    if let faceURL = user.faceURL {
                        data.avatarUrl = URL(string: faceURL)
                    }
                } else {
                    missC2CIds[convId] = data
                }
                data.avatarImage = DefaultAvatarImage
            } else if conv.getType() == .GROUP {
                data.avatarImage = DefaultGroupAvatarImage;
                data.title = conv.getGroupName()

                if let groupInfo: TIMGroupInfo = TIMGroupManager.sharedInstance().queryGroupInfo(groupId: convId) {
                    if let faceURL = groupInfo.faceURL {
                        data.avatarUrl = URL(string: faceURL)
                    }
                } else {
                    missGroupIds[convId] = data
                }
            }

            if let listFilter = self.listFilter {
                if (!listFilter(data)) {
                    continue;
                }
            }

            let existIdx = dataList.firstIndex(where: { (item) -> Bool in
                return item.convId == convId
            })

            if existIdx != nil {
                dataList[existIdx!] = data
            } else {
                dataList.append(data)
            }
        }
        
        fixMissIds()
        self.dataList = sort(dataList: dataList)
    }
   
    func sort(dataList: [TUIConversationCellData]) -> [TUIConversationCellData] {
    
        // 按时间排序，最近会话在上
        let nDataList = dataList.sorted { (obj1, obj2) -> Bool in
            guard let time1 = obj1.time else {
                return false
            }
            guard let time2 = obj2.time else {
                return true
            }
            return time1.compare(time2) == .orderedDescending
        }
        return nDataList
        
//        // 将置顶会话固定在最上面
//        NSArray *topList = [[TUILocalStorage sharedInstance] topConversationList];
//        int existTopListSize = 0;
//        for (NSString *userId in topList) {
//            int userIdx = -1;
//            for (int i = 0; i < dataList.count; i++) {
//                if ([dataList[i].convId isEqualToString:userId]) {
//                    userIdx = i;
//                    dataList[i].isOnTop = YES;
//                    break;
//                }
//            }
//            if (userIdx >= 0 && userIdx != existTopListSize) {
//                TUIConversationCellData *data = dataList[userIdx];
//                [dataList removeObjectAtIndex:userIdx];
//                [dataList insertObject:data atIndex:existTopListSize];
//                existTopListSize++;
//            }
//        }
    }

    func fixMissIds() {
//        @weakify(self)
//        NSArray *ids = [self.missC2CIds keyEnumerator].allObjects;
//
//        if (ids.count > 0) {
//            [[TIMFriendshipManager sharedInstance] getUsersProfile:[self.missC2CIds keyEnumerator].allObjects forceUpdate:YES succ:^(NSArray<TIMUserProfile *> *profiles) {
//                @strongify(self)
//                for (TIMUserProfile *pf in profiles) {
//                    TUIConversationCellData *data = [self.missC2CIds objectForKey:pf.identifier];
//                    if (data) {
//                        data.title = [pf showName];
//                        data.avatarUrl = [NSURL URLWithString:pf.faceURL];
//                    }
//                    [self.missC2CIds removeObjectForKey:pf.identifier];
//                }
//            } fail:nil];
//        }
//
//        ids = [self.missGroupIds keyEnumerator].allObjects;
//        if (ids.count > 0) {
//            [[TIMGroupManager sharedInstance] getGroupInfo:ids succ:^(NSArray<TIMGroupInfoResult *> *arr) {
//                @strongify(self)
//                for (TIMGroupInfoResult *gf in arr) {
//                    TUIConversationCellData *data = [self.missGroupIds objectForKey:gf.group];
//                    if (data) {
//                        data.avatarUrl = [NSURL URLWithString:gf.faceURL];
//                    }
//                    [self.missGroupIds removeObjectForKey:gf.group];
//                }
//            } fail:nil];
//        }
    }

    func getLastDisplayString(_ conv: TIMConversation) -> String? {
        guard let msg: TIMMessage = conv.getLastMsg() else {
            return nil
        }
        return msg.getDisplayString()
    }

    func getLastDisplayDate(_ conv: TIMConversation) -> Date? {
        guard let msg: TIMMessage = conv.getLastMsg() else {
//            return Date.distantPast
            return nil
        }
        
        return msg.timestamp()
    }
}
