//
//  TUIVoiceMessageCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/13.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import AVFoundation

/******************************************************************************
 *
 *  本文件声明了 TUIVoiceMessageCellData 类。
 *  本类继承于 TUIBubbleMessageCellData，用于存放文本消息单元所需的一系列数据与信息。
 *  本文件中已经实现了获取语音信息和相关数据处理的业务逻辑。
 *  当您需要获取语音数据时，直接调用本文件中声明的相关成员函数即可
 *
 ******************************************************************************/


/**
 * 【模块名称】TUIVoiceMessageCellData
 * 【功能说明】语音消息单元数据源
 *  语音消息单元，即你在发送语音时看到的消息单元。
 *  在TUIKit 的默认情况下，语音消息单元由气泡消息包裹，且内涵一个“声波”状图标。
 *  语音消息单元数据源，即包含了语音消息单元所需的一系列信息于数据，帮助语音消息能够正常显示与播放。
 *  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
 */
class TUIVoiceMessageCellData: TUIBubbleMessageCellData {
    
    
    
    
    /**
     *  上传时，语音文件的路径，接收时使用 IM SDK 接口中的 getSound 获得数据
     */
    var path: String?
    
    /**
     *  语音消息内部 ID
     */
    var uuid: String?
    
    /**
     *  语音消息的时长
     *  用于在消息单元处以 UILable 的形式，以秒为单元展示语音时长。
     */
    var duration: Int?
    
    /**
     *  语音消息数据大小
     */
    var length: Int?
    
    /**
     *  下载标志位
     *  YES：正在下载；NO：未在下载。
     */
    var isDownloading: Bool?
    
    /**
     *  播放标志位
     *  YES：正在播放；NO：未在播放。
     */
    var isPlaying: Bool?
    
    /**
     *  语音动态图标
     *  用于实现语音在播放时“声波图像”渐变的动画。
     *  tips：如果您想自定义实现其他种类的动画图标，你可以参照此处 voiceAnimationIamges 的实现。
     */
    var voiceAnimationImages = [NSImage]()
    
    /**
     *  语音图标
     *  用于显示语音未在播放时的动态图标。
     */
    var voiceImage: NSImage?
    var voiceTop: CGFloat = 0
    
    
    
    /**
     *  开始语音播放。
     *  开始当前气泡中的语音播放
     *  1-1、播放语音前会检查是否正在播放。若正在播放则不执行本次播放操作。
     *  1-2、当前为在播放时，则检查待播放音频是否存放在本地，若本地存在，则直接通过 path 获取音频并开始播放。
     *  2、当前音频不存在时，则通过 IM SDK 中 TIMSoundElem 类提供的 getSound 接口进行在线获取。
     *  3、语音消息和文件、图像、视频消息有所不同，获取的语音消息在消息中以 TIMSoundElem 存在，但无需进行二级提取即可使用。
     *  4、在播放时，只需在路径后添加语音文件后缀，生成 URL，即可根据对应 URL通过 iOS 自带的音频播放库播放。音频文件后缀为 “.wav”。
     *  5、下载成功后，会生成语音 path 并存储下来。
     */
    func playVoiceMessage() {
        fatalError()
        //        if (self.isPlaying) {
        //            return;
        //        }
        //        self.isPlaying = YES;
        //
        //        if(self.innerMessage.customInt == 0)
        //            self.innerMessage.customInt = 1;
        //
        //        BOOL isExist = NO;
        //        NSString *path = [self getVoicePath:&isExist];
        //        if(isExist) {
        //            [self playInternal:path];
        //        } else {
        //            if(self.isDownloading) {
        //                return;
        //            }
        //            //网络下载
        //            TIMSoundElem *imSound = [self getIMSoundElem];
        //            self.isDownloading = YES;
        //            @weakify(self)
        //            [imSound getSound:path succ:^{
        //                @strongify(self)
        //                self.isDownloading = NO;
        //                [self playInternal:path];;
        //            } fail:^(int code, NSString *msg) {
        //                @strongify(self)
        //                self.isDownloading= NO;
        //                [self stopVoiceMessage];
        //            }];
        //        }
    }
    
    var audioPlayer: AVAudioPlayer?
    var wavPath: String?
    
    override init(direction: MsgDirection) {
        super.init(direction: direction)
        //        if (direction == MsgDirectionIncoming) {
        //        self.cellLayout = [TIncommingVoiceCellLayout new];
        //                    _voiceImage = [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_receiver_normal")];
        //                    _voiceAnimationImages = [NSArray arrayWithObjects:
        //                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_receiver_playing_1")],
        //                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_receiver_playing_2")],
        //                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_receiver_playing_3")], nil];
        //                    _voiceTop = [[self class] incommingVoiceTop];
        //                } else {
        //                    self.cellLayout = [TOutgoingVoiceCellLayout new];
        //
        //                    _voiceImage = [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_sender_normal")];
        //                    _voiceAnimationImages = [NSArray arrayWithObjects:
        //                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_sender_playing_1")],
        //                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_sender_playing_2")],
        //                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIKitResource(@"message_voice_sender_playing_3")], nil];
        //                    _voiceTop = [[self class] outgoingVoiceTop];
        //                }
    }
    
    func getVoicePath(isExist: Bool) -> String? {
        fatalError()
        //        NSString *path = nil;
        //        BOOL isDir = false;
        //        *isExist = NO;
        //        if(self.direction == MsgDirectionOutgoing) {
        //            //上传方本地是否有效
        //            path = [NSString stringWithFormat:@"%@%@", TUIKit_Voice_Path, _path.lastPathComponent];
        //            if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
        //                if(!isDir){
        //                    *isExist = YES;
        //                }
        //            }
        //        }
        //
        //        if(!*isExist) {
        //            //查看本地是否存在
        //            path = [NSString stringWithFormat:@"%@%@.amr", TUIKit_Voice_Path, _uuid];
        //            if([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
        //                if(!isDir){
        //                    *isExist = YES;
        //                }
        //            }
        //        }
        //        return path;
    }
    
    func getIMSoundElem() -> TIMSoundElem? {
        fatalError()
        //        TIMMessage *imMsg = self.innerMessage;
        //        for (int i = 0; i < imMsg.elemCount; ++i) {
        //            TIMElem *imElem = [imMsg getElem:i];
        //            if([imElem isKindOfClass:[TIMSoundElem class]]){
        //                TIMSoundElem *imSoundElem = (TIMSoundElem *)imElem;
        //                return imSoundElem;
        //            }
        //        }
        //        return nil;
    }
    
    override func contentSize() -> CGSize {
        fatalError()
        //        CGFloat bubbleWidth = TVoiceMessageCell_Back_Width_Min + self.duration / TVoiceMessageCell_Max_Duration * Screen_Width;
        //            if(bubbleWidth > TVoiceMessageCell_Back_Width_Max){
        //                bubbleWidth = TVoiceMessageCell_Back_Width_Max;
        //            }
        //
        //            CGFloat bubbleHeight = TVoiceMessageCell_Duration_Size.height;
        //            if (self.direction == MsgDirectionIncoming) {
        //                bubbleWidth = MAX(bubbleWidth, [TUIBubbleMessageCellData incommingBubble].size.width);
        //                bubbleHeight = [TUIBubbleMessageCellData incommingBubble].size.height;
        //            } else {
        //                bubbleWidth = MAX(bubbleWidth, [TUIBubbleMessageCellData outgoingBubble].size.width);
        //                bubbleHeight = [TUIBubbleMessageCellData outgoingBubble].size.height;
        //            }
        //            return CGSizeMake(bubbleWidth+TVoiceMessageCell_Duration_Size.width, bubbleHeight);
        //        //    CGFloat width = bubbleWidth + TVoiceMessageCell_Duration_Size.width;
        //        //    return CGSizeMake(width, TVoiceMessageCell_Duration_Size.height);
    }
    
    
    func playInternal(path: String) {
        fatalError()
        //        if (!self.isPlaying)
        //            return;
        //        //play current
        //        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        //        NSURL *url = [NSURL fileURLWithPath:path];
        //        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        //        self.audioPlayer.delegate = self;
        //        bool result = [self.audioPlayer play];
        //        if (!result) {
        //            self.wavPath = [[path stringByDeletingPathExtension] stringByAppendingString:@".wav"];
        //            [THelper convertAmr:path toWav:self.wavPath];
        //            NSURL *url = [NSURL fileURLWithPath:self.wavPath];
        //            [self.audioPlayer stop];
        //            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        //            self.audioPlayer.delegate = self;
        //            [self.audioPlayer play];
        //        }
    }
    
    /**
     *  停止语音播放。
     *  停止当前气泡中的语音播放
     */
    func stopVoiceMessage() {
        fatalError()
        //        if ([self.audioPlayer isPlaying]) {
        //            [self.audioPlayer stop];
        //            self.audioPlayer = nil;
        //        }
        //        self.isPlaying = NO;
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully: Bool) {
        fatalError()
        //        self.isPlaying = NO;
        //        [[NSFileManager defaultManager] removeItemAtPath:self.wavPath error:nil];
    }
    /**
     *  接收语音图标顶部
     *  该数值用于确定气泡位置，方便气泡内的内容进行 UI 布局。
     *  若该数值出现异常或者随意设置，会出现消息位置错位等 UI 错误。
     */
    static var incommingVoiceTop: CGFloat = 12
    
    /**
     *  接收语音图标顶部
     *  该数值用于确定气泡位置，方便气泡内的内容进行 UI 布局。
     *  若该数值出现异常或者随意设置，会出现消息位置错位等 UI 错误。
     */
    static var outgoingVoiceTop: CGFloat = 12;
    
    
}
