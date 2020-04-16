//
//  TUIVideoMessageCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/13.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

let TVideo_Block_Progress = "TVideo_Block_Progress"
let TVideo_Block_Response = "TVideo_Block_Response"


/******************************************************************************
  *
  *  本文件声明了 TUIVideoItem 类、TUISnapshotItem 类和 TUIVideoMessageCellData 类。
  *  TUIVideoItem 对应 IM SDK 中的视频元素类，我们将 SDK 中的类转换为 TUIVideoItem，方便我们进一步对数据进行处理与操作。
  *  TUISnapshotItem 对应 IM SDK 中的视频封面类，本质上仍是一个图像，只是与对应 Video 绑定存在。
  *  TUIVideoMessageCellData 继承于 TUIMessageCellData 类，用于存放图像消息单元所需的一系列数据与信息。
  *  本文件中已经实现了获取视频信息和封面信息的业务逻辑。
  *  当您需要获取视频和封面数据时，直接调用本文件中声明的相关成员函数即可
  *
 ******************************************************************************/


/////////////////////////////////////////////////////////////////////////////////
//
//                             TUIVideoItem
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 【模块名称】TUIVideoItem
 * 【功能说明】视频项目
 *  存放在 TUIVideoMessageCellData中
 *  包含视频的通用识别码、视频类型、视频大小以及视频长度。
 */
class TUIVideoItem {

/**
 *  视频消息内部 ID，不用设置，通过 SDK 拉取的视频实例中获取。
 */
    var uuid: String?

/**
 *  视频类型，即后缀格式，发送消息时设置。比如“mp4”。
 */
    var type: String?

/**
 *  视频体积大小，无需设置，通过 SDK 拉取的实例中获取。
 */
    var length: Int = 0

/**
 *  视频时长
 */
    var duration: Int = 0
}

/////////////////////////////////////////////////////////////////////////////////
//
//                            TUISnapshotItem
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 【模块名称】TUISnapshotItem
 * 【功能说明】视频封面
 *  用于在消息单元中显示视频的封面。
 */
class TUISnapshotItem {

/**
 *  图片 ID，内部标识，可用于外部缓存key
 */
    var uuid: String?

/**
 *  封面图片 类型，即缩略图。
 */
    var type: String?

/**
 *  封面在 UI 上的大小。
 */
    var size: CGSize = .zero

/**
 *  封面数据大小。
 */
    var length: Int = 0
}

/////////////////////////////////////////////////////////////////////////////////
//
//                            TUIVideoMessageCellData
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 【模块名称】TUIVideoMessageCellData
 * 【功能说明】视频消息单元数据源。
 *  视频消息单元，即包含了视频的消息单元。
 *  视频消息单元数据源包含了视频消息单元所需的一系列消息和数据。
 *  同时，本消息单元整合调用了 IM SDK，通过 SDK 提供的接口进行视频的在线获取。
 *  本类配合消息控制器实现了视频消息的播放等业务逻辑。
 *  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
 */
class TUIVideoMessageCellData: TUIMessageCellData {

/**
 *  缩略图图像
 */
    var thumbImage: NSImage?

/**
 *  视频路径
 *  用于视频在本地的存取
 */
    var videoPath: String?

/**
 *  快照路径
 *  用于快照在本地的存取。
 */
    var snapshotPath: String?

/**
 *  视频消息的视频项目
 */
    var videoItem: TUIVideoItem?

/**
 *  视频消息的快照项目
 */
    var snapshotItem: TUISnapshotItem?



/**
 *  缩略图获取进度
 */
    var thumbProgress: Int = 0

/**
 *  视频获取进度
 */
    var videoProgress: Int = 0

    private var isDownloadingSnapshot: Bool = false
    private var isDownloadingVideo: Bool = false

    /**
    *  获取视频封面
    *  本函数整合调用了 IM SDK，通过 SDK 提供的接口在线获取封面。
    *  1、下载前会判断封面是否在本地，若不在本地，则在本地直接获取封面文件。
    *  2、当封面不在本地时，通过 IM SDK 中 TIMSnapshot 类提供的 getImage 接口在线获取。
    *  3-1、下载进度百分比则通过接口回调的 progress（代码块）参数进行更新。
    *  3-2、代码块具有 curSize 和 totalSize 两个参数，由回调函数维护 curSize，然后通过 curSize * 100 / totalSize 计算出当前进度百分比。
    *  4-1、视频消息中存放的格式为 IMVideoElem，您可以通过 IMVideoElem.snapshot 获取封面实例。
    *  4-2、通过 SDK 接口获取的图像为二进制文件，需先进行解码，转换为 CGIamge 进行解码操作后包装为 UIImage 才可使用。
    *  5、下载成功后，会生成封面 path 并存储下来。
    */
    func downloadThumb() {
        fatalError()
//        BOOL isExist = NO;
//        NSString *path = [self getSnapshotPath:&isExist];
//        if (isExist) {
//            [self decodeThumb];
//            return;
//        }
//
//        if(self.isDownloadingSnapshot) {
//            return;
//        }
//        self.isDownloadingSnapshot = YES;
//
//
//        //网络下载
//        @weakify(self)
//        TIMSnapshot *imSnapshot = [self getIMSnapshot];
//        [imSnapshot getImage:path progress:^(NSInteger curSize, NSInteger totalSize) {
//            [self updateThumbProgress:curSize * 100 / totalSize];
//        } succ:^{
//            @strongify(self)
//            self.isDownloadingSnapshot = NO;
//            [self updateThumbProgress:100];
//            [self decodeThumb];
//        } fail:^(int code, NSString *msg) {
//            @strongify(self)
//            self.isDownloadingSnapshot = NO;
//        }];
    }
    func updateThumbProgress(progress: Int) {
        fatalError()
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.thumbProgress = progress;
//        });
    }
    func decodeThumb() {
        fatalError()
//        BOOL isExist = NO;
//        NSString *path = [self getSnapshotPath:&isExist];
//        if (!isExist) {
//            return;
//        }
//        [THelper asyncDecodeImage:path complete:^(NSString *path, UIImage *image) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.thumbImage = image;
//                self.thumbProgress = 100;
//            });
//        }];
    }

    /**
    *  获取视频
    *  本函数整合调用了 IM SDK，通过 SDK 提供的接口在线获取视频。
    *  1、下载前会判断视频是否在本地，若不在本地，则在本地直接获取视频文件。
    *  2、当视频不在本地时，通过 IM SDK 中 TIMVideo 类提供的 getVideo 接口在线获取。
    *  3-1、下载进度百分比则通过接口回调的 progress（代码块）参数进行更新。
    *  3-2、代码块具有 curSize 和 totalSize 两个参数，由回调函数维护 curSize，然后通过 curSize * 100 / totalSize 计算出当前进度百分比。
    *  4、视频消息中存放的格式为 IMVideoElem，该类实例无法通过播放器直接播放，您可以通过 IMVideoElem.video 获取视频实例。
    *  5、下载成功后，会生成视频 path 并存储下来。
    */
    func downloadVideo() {
        fatalError()
//        BOOL isExist = NO;
//        NSString *path = [self getVideoPath:&isExist];
//        if (isExist) {
//            return;
//        }
//
//        if(self.isDownloadingVideo) {
//            return;
//        }
//        self.isDownloadingVideo = YES;
//
//        //网络下载
//        @weakify(self)
//        TIMVideo *imVideo = [self getIMVideo];
//        [imVideo getVideo:path progress:^(NSInteger curSize, NSInteger totalSize) {
//            @strongify(self)
//            [self updateVideoProgress:curSize * 100 / totalSize];
//        } succ:^{
//            @strongify(self)
//            self.isDownloadingVideo = NO;
//            [self updateThumbProgress:100];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.videoPath = path;
//            });
//        } fail:^(int code, NSString *msg) {
//            @strongify(self)
//            self.isDownloadingVideo = NO;
//        }];
    }

    func updateVideoProgress(progress: UInt) {
        fatalError()
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.videoProgress = progress;
//        });
    }
    /**
    *  判断视频是否在本地存在
    *
    *  @return YES：视频存在于本地；NO：视频在本地不存在。
    */
    func isVideoExist() -> Bool {
        fatalError()
//        BOOL isExist;
//        [self getVideoPath:&isExist];
//        return isExist;
    }

    func getVideoPath(isExist: inout Bool) -> String? {
        fatalError()
//        NSString *path = nil;
//        BOOL isDir = NO;
//        *isExist = NO;
//        if(self.direction == MsgDirectionOutgoing){
//            //上传方本地原图是否有效
//            path = [NSString stringWithFormat:@"%@%@", TUIKit_Video_Path, _videoPath.lastPathComponent];
//            if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
//                if(!isDir){
//                    *isExist = YES;
//                }
//            }
//        }
//
//        if(!*isExist){
//            if(_videoItem){
//                //查看本地是否存在
//                path = [NSString stringWithFormat:@"%@%@.%@", TUIKit_Video_Path, _videoItem.uuid, _videoItem.type];
//                if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
//                    if(!isDir){
//                        *isExist = YES;
//                    }
//                }
//            }
//        }
//        if (*isExist) {
//            _videoPath = path;
//        }
//
//        return path;
    }

    func getSnapshotPath(isExist: inout Bool) -> String? {
        fatalError()
//        NSString *path = nil;
//        BOOL isDir = NO;
//        *isExist = NO;
//        if(self.direction == MsgDirectionOutgoing){
//            //上传方本地是否有效
//            path = [NSString stringWithFormat:@"%@%@", TUIKit_Video_Path, _snapshotPath.lastPathComponent];
//            if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
//                if(!isDir){
//                    *isExist = YES;
//                }
//            }
//        }
//
//        if(!*isExist){
//            if(_snapshotItem){
//                //查看本地是否存在
//                path = [NSString stringWithFormat:@"%@%@", TUIKit_Video_Path, _snapshotItem.uuid];
//                path = [TUIKit_Video_Path stringByAppendingString:_snapshotItem.uuid];
//                if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
//                    if(!isDir){
//                        *isExist = YES;
//                    }
//                }
//            }
//        }
//
//        return path;
    }

    func getIMSnapshot() -> TIMSnapshot? {
        fatalError()
//        TIMMessage *imMsg = self.innerMessage;
//        for (int i = 0; i < imMsg.elemCount; ++i) {
//            TIMElem *imElem = [imMsg getElem:i];
//            if([imElem isKindOfClass:[TIMVideoElem class]]){
//                TIMVideoElem *imVideoElem = (TIMVideoElem *)imElem;
//                return imVideoElem.snapshot;
//            }
//        }
//        return nil;
    }

    func getIMVideo() -> TIMVideo? {
        fatalError()
//        TIMMessage *imMsg = self.innerMessage;
//        for (int i = 0; i < imMsg.elemCount; ++i) {
//            TIMElem *imElem = [imMsg getElem:i];
//            if([imElem isKindOfClass:[TIMVideoElem class]]){
//                TIMVideoElem *imVideoElem = (TIMVideoElem *)imElem;
//                return imVideoElem.video;
//            }
//        }
//        return nil;
    }

    override func contentSize() -> CGSize {
        fatalError()
//        CGSize size = CGSizeZero;
//        BOOL isDir = NO;
//        if(![self.snapshotPath isEqualToString:@""] &&
//           [[NSFileManager defaultManager] fileExistsAtPath:self.snapshotPath isDirectory:&isDir]){
//            if(!isDir){
//                size = [UIImage imageWithContentsOfFile:self.snapshotPath].size;
//            }
//        }
//        else{
//            size = self.snapshotItem.size;
//        }
//        if(CGSizeEqualToSize(size, CGSizeZero)){
//            return size;
//        }
//        if(size.height > size.width){
//            size.width = size.width / size.height * TVideoMessageCell_Image_Height_Max;
//            size.height = TVideoMessageCell_Image_Height_Max;
//        }
//        else{
//            size.height = size.height / size.width * TVideoMessageCell_Image_Width_Max;
//            size.width = TVideoMessageCell_Image_Width_Max;
//        }
//        return size;
    }
}

