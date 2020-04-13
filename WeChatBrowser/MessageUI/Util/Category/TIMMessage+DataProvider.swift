//
//  TIMMessage+DataProvider.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

extension TIMMessage {
    var expr: TUIMessageDataProviderServiceProtocol {
        get {
            return TCServiceManager.shareInstance().messageDataProviderService
        }
    }
    
    func cellData(fromElem elem: TIMElem) -> TUIMessageCellData? {
        return expr.getCellData(message: self, fromElem: elem)
    }

    func getDisplayString(friendshipManager: TIMFriendshipManager) -> String? {
        return expr.getDisplayString(friendshipManager: friendshipManager, message: self)
    }

//- (TUITextMessageCellData *) textCellDataFromElem:(TIMTextElem *)elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getTextCellData:self fromElem:elem];
//}
//
//- (TUIFaceMessageCellData *) faceCellDataFromElem:(TIMFaceElem *)elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getFaceCellData:self fromElem:elem];
//}
//
//- (TUIImageMessageCellData *) imageCellDataFromElem:(TIMImageElem *) elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getImageCellData:self fromElem:elem];
//}
//
//- (TUIVoiceMessageCellData *) voiceCellDataFromElem:(TIMSoundElem *)elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getVoiceCellData:self fromElem:elem];
//}
//
//- (TUIVideoMessageCellData *) videoCellDataFromElem:(TIMVideoElem *)elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getVideoCellData:self fromElem:elem];
//}
//
//- (TUIFileMessageCellData *) fileCellDataFromElem:(TIMFileElem *)elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getFileCellData:self fromElem:elem];
//}
    func revokeCellData() -> TUISystemMessageCellData {
        return expr.getRevokeCellData(message: self)
    }

}
