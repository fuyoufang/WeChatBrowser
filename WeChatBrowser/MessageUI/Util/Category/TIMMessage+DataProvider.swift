//
//  TIMMessage+DataProvider.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

extension TIMMessage {

//-(id)cellDataFromElem:(TIMElem *)elem{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getCellData:self fromElem:elem];
//}

    var expr: TUIMessageDataProviderServiceProtocol {
        get {
            return TCServiceManager.shareInstance().messageDataProviderService
        }
    }

    func getDisplayString() -> String? {
        return expr.getDisplayString(message: self)
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
//- (TUISystemMessageCellData *) revokeCellData{
//    id<TUIMessageDataProviderServiceProtocol> expr = [[TCServiceManager shareInstance] createService:@protocol(TUIMessageDataProviderServiceProtocol)];
//    return [expr getRevokeCellData:self];
//}

}
