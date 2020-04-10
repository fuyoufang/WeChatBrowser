//
//  IMMessage.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

// MARK: 一，消息封装

/////////////////////////////////////////////////////////////////////////////////
//
//                      （一）消息封装
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 消息封装
/// @{

/**
 IMMessage 由多个 TIMElem 组成，每个 TIMElem 可以是文本和图片，也就是说每一条消息可包含多个文本和多张图片。详情请参考官网文档 [消息收发](https://cloud.tencent.com/document/product/269/9150)
 */
class TIMMessage {
    
/**
 *  1.1 增加 Elem
 *
 *  @param elem elem 结构
 *
 *  @return 0：表示成功；1：禁止添加 Elem（文件或语音多于两个 Elem）；2：未知 Elem
 */
    func add(elem: TIMElem) -> Int {
        fatalError()
    }

/**
 *  1.2 获取对应索引的 Elem
 *
 *  @param index 对应索引
 *
 *  @return 返回对应 Elem
 */
    func getElem(index: Int) -> TIMElem?  {
        fatalError()
    }

/**
 *  1.3 获取 Elem 数量
 *
 *  @return elem数量
 */
    func elemCount() -> Int {
        fatalError()
    }
    
/**
 *  1.5 消息状态
 *
 *  @return IMMessageStatus 消息状态
 */
    func status() -> IMMessageStatus {
        fatalError()
    }

/**
 *  1.6 是否发送方
 *
 *  @return TRUE：表示是发送消息；FALSE：表示是接收消息
 */
    func isSelf() -> Bool {
        fatalError()
    }

/**
 *  1.7 获取消息的发送方
 *
 *  @return 发送方 identifier
 */
    func sender() -> String {
        fatalError()
    }

/**
 *  1.8 消息 ID
 *
 *  1. 当消息生成时，就已经固定，这种方式可能跟其他用户产生的消息冲突，需要再加一个时间约束，可以认为 10 分钟以内的消息可以使用 msgId 区分，需要在同一个会话内判断。
 *  2. 对于发送成功的消息或则从服务器接收到的消息，请使用 uniqueId 判断消息的全局唯一。
 *
 *  @return msgId
 *
 */
    func msgId() -> String {
        fatalError()
    }

/**
 *  1.9 消息 uniqueId
 *
 *  对于发送成功的消息或则从服务器接收到的消息，uniqueId 能保证全局唯一，需要在同一个会话内判断。
 *
 *  @return uniqueId
 */
    func uniqueId() -> Int64 {
        fatalError()
    }

/**
 *  1.10 当前消息的时间戳
 *
 *  当消息还没发送成功，此时间为根据 Server 时间校准过的本地时间，发送成功后会改为准确的 Server 时间
 *
 *  @return 时间戳
 */
    func timestamp() -> Date {
        fatalError()
    }

/**
 *  1.11 自己是否已读
 *
 *  注意 ChatRoom、AVChatRoom、BChatRoom 不支持未读的功能，isReaded 接口针对这些类型房间无效。
 *
 *  @return TRUE：已读；FALSE：未读
 */
    func isReaded() -> Bool {
        fatalError()
    }

/**
 *  1.12 对方是否已读（仅 C2C 消息有效）
 *
 *  @return TRUE：已读；FALSE：未读
 */
    func isPeerReaded() -> Bool {
        fatalError()
    }

/**
 *  1.13 消息定位符
 *
 *  如果是自己创建的 IMMessage，需要等到消息发送成功后才能获取到 IMMessageLocator 里面的具体信息
 *
 *  @return locator，详情请参考 TIMComm.h 里面的 IMMessageLocator 定义
 */
//- (IMMessageLocator*)locator;

/**
 *  1.14 是否为 locator 对应的消息
 *
 *  @param locator 消息定位符
 *
 *  @return YES 是对应的消息
 */
//- (Bool)respondsToLocator:(IMMessageLocator*)locator;


/**
 *  1.16 获取会话
 *
 *  @return 该消息所对应会话
 */

    func getConversation() -> TIMConversation {
        fatalError()
    }

/**
 *  1.17 获取发送者昵称
 *
 *  @return  发送者昵称
 *
 */
    func getSenderNickname() -> String? {
        fatalError()
    }


/**
 *  1.18 获取发送者资料
 *
 *  如果本地有发送者资料，会在 profileCallBack 回调里面立即同步返回发送者资料，如果本地没有发送者资料，SDK 内部会先向服务器拉取发送者资料，并在 profileCallBack 回调里面异步返回发送者资料。
 *
 *  @param  profileCallBack 发送者资料回调
 *
 */
//- (void)getSenderProfile:(ProfileCallBack)profileCallBack;

/**
 *  1.19 获取发送者群内资料
 *
 *  目前仅能获取字段：member，nameCard，其他的字段获取建议通过 TIMGroupManager.h -> getGroupMembersInfo 获取
 *
 *  @return 发送者群内资料，nil 表示没有获取到资料或者不是群消息
 */
//- (TIMGroupMemberInfo*)getSenderGroupMemberProfile;

/**
 *  1.24 设置自定义整数，默认为 0
 *
 *  1.此自定义字段仅存储于本地，不会同步到 Server，用户卸载应用或则更换终端后无法获取。
 *  2.可以根据这个字段设置语音消息是否已经播放，如 customInt 的值 0 表示未播放，1 表示播放，当用户单击播放后可设置 customInt 的值为 1。
 *
 *  @param param 设置参数
 *
 *  @return TRUE：设置成功；FALSE:设置失败
 */
    
    var customInt: Int {
        get {
            fatalError()
        }
    }

/**
 *  1.26 设置自定义数据，默认为""
 *
 *  此自定义字段仅存储于本地，不会同步到 Server，用户卸载应用或则更换终端后无法获取。
 *
 *  @param data 设置参数
 *
 *  @return TRUE：设置成功；FALSE:设置失败
 */
    func set(customData: Data) -> Bool {
        fatalError()
    }

/**
 *  1.27 获取 CustomData
 *
 *  @return CustomData
 */
    func customData() -> Data {
        fatalError()
    }

/**
 *  1.28 拷贝消息中的属性（ELem、priority、online、offlinePushInfo）
 *
 *  @param srcMsg 源消息
 *
 *  @return 0 成功
 */
//- (int)copyFrom:(IMMessage*)srcMsg;

/**
 *  1.29 将消息导入到本地
 *
 *  只有调用这个接口，才能去修改消息的时间戳和发送方
 *
 *  @return 0：成功；1：失败
 */
//- (int)convertToImportedMsg;

/**
 *  1.30 设置消息时间戳
 *
 *  需要先将消息到导入到本地，调用 convertToImportedMsg 方法
 *
 *  @param time 时间戳
 *
 *  @return 0：成功；1：失败
 */
//- (int)setTime:(time_t)time;

/**
 *  1.31 设置消息发送方
 *
 *  需要先将消息到导入到本地，调用 convertToImportedMsg 方法
 *
 *  @param sender 发送方 identifier
 *
 *  @return 0：成功；1：失败
 */
//- (int)setSender:(NSString*)sender;

}

/// @}

// MARK: 三，消息 Elem 基类
/////////////////////////////////////////////////////////////////////////////////
//
//                      （三）消息 Elem 基类
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 消息 Elem 基类
/// @{

/**
 *  消息 Elem 基类
 */
class TIMElem {
    
}


/// @}

// MARK: 四，文本消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （四）文本消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 文本消息 Elem
/// @{

/**
 *  文本消息 Elem
 */
class TIMTextElem: TIMElem {
    
/**
 *  消息文本
 */
    var text: String?
}

// MARK:  五，图片消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （五）图片消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 图片消息 Elem
/// @{

/**
 *  图片
 */
class TIMImage {
    /**
     *  图片 ID，内部标识，可用于外部缓存key
     */
    var uuid: String?
    /**
     *  图片类型
     */
    var type: TIM_IMAGE_TYPE?
    /**
     *  图片大小
     */
    var size: Int?
    /**
     *  图片宽度
     */
    var width: Int?
    /**
     *  图片高度
     */
    var height: Int?
    /**
     *  下载URL
     */
    var url: String?

    /**
     *  获取图片
     *
     *  下载的数据需要由开发者缓存，IM SDK 每次调用 getImage 都会从服务端重新下载数据。建议通过图片的 uuid 作为 key 进行图片文件的存储。
     *
     *  @param path 图片保存路径
     *  @param succ 成功回调，返回图片数据
     *  @param fail 失败回调，返回错误码和错误描述
     */
    func getImage(path: String, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }

    /**
     *  获取图片（有进度回调）
     *
     *  下载的数据需要由开发者缓存，IM SDK 每次调用 getImage 都会从服务端重新下载数据。建议通过图片的 uuid 作为 key 进行图片文件的存储。
     *
     *  @param path 图片保存路径
     *  @param progress 图片下载进度
     *  @param succ 成功回调，返回图片数据
     *  @param fail 失败回调，返回错误码和错误描述
     */
    func getImage(path: String, progress: TIMProgress, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }
}

/**
 *  图片消息Elem
 */
class TIMImageElem: TIMElem {

/**
 *  要发送的图片路径
 */
var path: String?

/**
 *  所有类型图片，只读，发送的时候不用关注，接收的时候这个字段会保存图片的所有规格，目前最多包含三种规格：原图、大图、缩略图，每种规格保存在一个 TIMImage 对象中
 */
var imageList: [TIMImage]?


/**
 *  图片压缩等级，详见 TIM_IMAGE_COMPRESS_TYPE（仅对 jpg 格式有效）
 */
var level: TIM_IMAGE_COMPRESS_TYPE?

/**
 *  图片格式，详见 TIM_IMAGE_FORMAT
 */
var format: TIM_IMAGE_FORMAT?

}

/// @}

// MARK:  六，语音消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （六）语音消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 语音消息 Elem
/// @{

/**
 *  语音消息Elem
 *
 *  1. 一条消息只能有一个语音 Elem，添加多条语音 Elem 时，AddElem 函数返回错误 1，添加不生效。
 *  2. 语音和文件 Elem 不一定会按照添加时的顺序获取，建议逐个判断 Elem 类型展示，而且语音和文件 Elem 也不保证按照发送的 Elem 顺序排序。
 *
 */
class TIMSoundElem: TIMElem {
/**
 *  上传时，语音文件的路径，接收时使用 getSound 获得数据
 */
var path: String?
/**
 *  语音消息内部 ID
 */
var uuid: String?
/**
 *  语音数据大小
 */
var dataSize: Int = 0
/**
 *  语音长度（秒），发送消息时设置
 */
var second: Int = 0

/**
 *  获取语音的 URL 下载地址
 *
 *  @param urlCallBack 获取 URL 地址回调
 */
    func getUrl(urlCallBack: (_ url: String) -> Void) {
        fatalError()
    }
/**
 *  获取语音数据到指定路径的文件中
 *
 *  getSound 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 语音保存路径
 *  @param succ 成功回调
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getSound(path: String, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }

/**
 *  获取语音数据到指定路径的文件中（有进度回调）
 *
 *  getSound 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 语音保存路径
 *  @param progress 语音下载进度
 *  @param succ 成功回调
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getSound(path: String, progress: TIMProgress, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }
}

/// @}

// MARK:  七，视频消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （七）视频消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 视频消息 Elem
/// @{

/**
 *  视频
 */
class TIMVideo {
/**
 *  视频消息内部 ID，不用设置
 */
var uuid: String?
/**
 *  视频文件类型，发送消息时设置
 */
var type: String?
/**
 *  视频大小，不用设置
 */
var size: Int?
/**
 *  视频时长，发送消息时设置
 */
var duration: Int?

/**
 *  获取视频的 URL 下载地址
 *
 *  @param urlCallBack 获取 URL 地址回调
 */
    func getUrl(urlCallBack: (_ url: String) -> Void) {
        fatalError()
    }

/**
 *  获取视频
 *
 *  getVideo 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 视频保存路径
 *  @param succ 成功回调
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getVideo(path: String, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }

/**
 *  获取视频（有进度回调）
 *
 *  getVideo 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 视频保存路径
 *  @param progress 视频下载进度
 *  @param succ 成功回调
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getVideo(path: String, progress: TIMProgress, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }
}

/**
 *  视频消息 Elem
 */
class TIMVideoElem: TIMElem {

/**
 *  视频文件路径，发送消息时设置
 */
var videoPath: String?

/**
 *  视频信息，发送消息时设置
 */
var video: TIMVideo?

/**
 *  截图文件路径，发送消息时设置
 */
var snapshotPath: String?

/**
 *  视频截图，发送消息时设置
 */
var snapshot: TIMSnapshot?

}

/// @}

// MARK:  八，文件消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （八）文件消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 文件消息
/// @{

/**
 *  文件消息Elem
 */
class TIMFileElem: TIMElem {

/**
 *  上传时，文件的路径（设置 path 时，优先上传文件）
 */
var path: String?
/**
 *  文件内部 ID
 */
var uuid: String?
/**
 *  文件大小
 */
var fileSize: Int = 0
/**
 *  文件显示名，发消息时设置
 */
var filename: String?

/**
 *  获取文件的 URL 下载地址
 *
 *  @param urlCallBack 获取 URL 地址回调
 */
func getUrl(urlCallBack: (_ url: String) -> Void) {
        fatalError()
    }

/**
 *  获取文件数据到指定路径的文件中
 *
 *  getFile 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 文件保存路径
 *  @param succ 成功回调，返回数据
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getFile(path: String, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }

/**
 *  获取文件数据到指定路径的文件中（有进度回调）
 *
 *  getFile 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 文件保存路径
 *  @param progress 文件下载进度
 *  @param succ 成功回调，返回数据
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getFile(path: String, progress: TIMProgress, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }
}

/// @}

// MARK:  九，表情消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （九）表情消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 表情消息 Elem
/// @{

/**
 *  表情消息类型
 *
 *  1. 表情消息由 TIMFaceElem 定义，SDK 并不提供表情包，如果开发者有表情包，可使用 index 存储表情在表情包中的索引，由用户自定义，或者直接使用 data 存储表情二进制信息以及字符串 key，都由用户自定义，SDK 内部只做透传。
 *  2. index 和 data 只需要传入一个即可，ImSDK 只是透传这两个数据。
 *
 */
class TIMFaceElem: TIMElem {

/**
 *  表情索引，用户自定义
 */
var index: Int?
/**
 *  额外数据，用户自定义
 */
var data: Data?

}

/// @}

// MARK:  十，地理位置消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十）地理位置消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 地理位置消息 Elem
/// @{

/**
 *  地理位置Elem
 */
class TIMLocationElem: TIMElem {
/**
 *  地理位置描述信息，发送消息时设置
 */
var desc: String?
/**
 *  纬度，发送消息时设置
 */
var latitude: Double?
/**
 *  经度，发送消息时设置
 */
var longitude: Double?
}

/// @}

// MARK:  十一，截图消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十一）截图消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 截图消息 Elem
/// @{

/**
 *  截图消息 Elem
 */
class TIMSnapshot {
/**
 *  图片 ID，不用设置
 */
var uuid: String?
/**
 *  截图文件类型，发送消息时设置
 */
var type: String?
/**
 *  图片大小，不用设置
 */
var size: Int?
/**
 *  图片宽度，发送消息时设置
 */
var width: Int?
/**
 *  图片高度，发送消息时设置
 */
var height: Int?

/**
 *  获取截图的 URL 下载地址
 *
 *  @param urlCallBack 获取 URL 地址回调
 */
    func getUrl(urlCallBack: (_ url: String) -> Void) {
        fatalError()
    }

/**
 *  获取图片
 *
 *  getImage 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 图片保存路径
 *  @param succ 成功回调，返回图片数据
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getImage(path: String, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }
/**
 *  获取图片（有进度回调）
 *
 *  getImage 接口每次都会从服务端下载，如需缓存或者存储，开发者可根据 uuid 作为 key 进行外部存储，ImSDK 并不会存储资源文件。
 *
 *  @param path 图片保存路径
 *  @param progress 图片下载进度
 *  @param succ 成功回调，返回图片数据
 *  @param fail 失败回调，返回错误码和错误描述
 */
    func getImage(path: String, progress: TIMProgress, succ: TIMSucc, fail: TIMFail) {
        fatalError()
    }
}

/// @}

// MARK:  十二，自定义消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十二）自定义消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 自定义消息 Elem
/// @{

/**
 *  自定义消息类型
 *
 *  自定义消息是指当内置的消息类型无法满足特殊需求，开发者可以自定义消息格式，内容全部由开发者定义，IM SDK 只负责透传。自定义消息由 TIMCustomElem 定义，其中 data 存储消息的二进制数据，其数据格式由开发者定义，desc 存储描述文本。一条消息内可以有多个自定义 Elem，并且可以跟其他 Elem 混合排列，离线 Push 时叠加每个 Elem 的 desc 描述信息进行下发。
 *
 */
class TIMCustomElem: TIMElem {

/**
 *  自定义消息二进制数据
 */
var data: Data?
}

/// @}

// MARK:  十三，群 Tips 消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十三）群 Tips 消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 群 Tips 消息 Elem
/// @{

/**
 *  群tips，成员变更信息
 */
class TIMGroupTipsElemMemberInfo {

/**
 *  变更用户
 */
var identifier: String?
/**
 *  禁言时间（秒，表示还剩多少秒可以发言）
 */
var shutupTime: UInt32?

}

/**
 *  群 tips，群变更信息
 */
class TIMGroupTipsElemGroupInfo {

/**
 *  变更类型
 */
    var type: TIM_GROUP_INFO_CHANGE_TYPE?

/**
 *  根据变更类型表示不同含义
 */
var value: String?

/**
 *  如果变更类型是群自定义字段,key 对应的是具体变更的字段，群自定义字段的变更只会通过 TIMUserConfig -> TIMGroupEventListener 回调给客户
 */
var key: String?
}

/**
 *  群 Tips
 */
class TIMGroupTipsElem: TIMElem {

/**
 *  群组 ID
 */
var group: String?

/**
 *  群Tips类型
 */
var type: TIM_GROUP_TIPS_TYPE?

/**
 *  操作人用户名
 */
var opUser: String?

/**
 *  被操作人列表 NSString* 数组
 */
var userList: [String]?

/**
 *  在群名变更时表示变更后的群名，否则为 nil
 */
var groupName: String?

/**
 *  群信息变更： TIM_GROUP_TIPS_TYPE_INFO_CHANGE 时有效，为 TIMGroupTipsElemGroupInfo 结构体列表
 */
var groupChangeList: [TIMGroupTipsElemGroupInfo]?

/**
 *  成员变更： TIM_GROUP_TIPS_TYPE_MEMBER_INFO_CHANGE 时有效，为 TIMGroupTipsElemMemberInfo 结构体列表
 */
var memberChangeList: [TIMGroupTipsElemMemberInfo]?

/**
 *  操作者用户资料
 */
var opUserInfo: TIMUserProfile?
/**
 *  操作者群成员资料
 */
var opGroupMemberInfo: TIMGroupMemberInfo?
/**
 *  变更成员资料
 */
    var changedUserInfo: [String : TIMUserProfile]?
/**
 *  变更成员群内资料
 */
    var changedGroupMemberInfo: [String : TIMGroupMemberInfo]?

/**
 *  当前群人数： TIM_GROUP_TIPS_TYPE_INVITE、TIM_GROUP_TIPS_TYPE_QUIT_GRP、
 *             TIM_GROUP_TIPS_TYPE_KICKED时有效
 */
var memberNum: UInt32?


/**
 *  操作方平台信息
 *  取值： iOS Android Windows Mac Web RESTAPI Unknown
 */
var platform: String?

}

/// @}

// MARK:  十四，群系统消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十四）群系统消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 群系统消息 Elem
/// @{

/**
 *  群系统消息
 */
class TIMGroupSystemElem: TIMElem {

/**
 * 操作类型
 */
var type: TIM_GROUP_SYSTEM_TYPE?

/**
 * 群组 ID
 */
var group: String?

/**
 * 操作人
 */
var user: String?

/**
 * 操作理由
 */
var msg: String?

/**
 *  消息标识，客户端无需关心
 */
var msgKey: UInt64?

/**
 *  消息标识，客户端无需关心
 */
var authKey: Data?

/**
 *  用户自定义透传消息体（type ＝ TIM_GROUP_SYSTEM_CUSTOM_INFO 时有效）
 */
var userData: Data?

/**
 *  操作人资料
 */
var opUserInfo: TIMUserProfile?

/**
 *  操作人群成员资料
 */
var opGroupMemberInfo: TIMGroupMemberInfo?

/**
 *  操作方平台信息
 *  取值： iOS、Android、Windows、Mac、Web、RESTAPI、Unknown
 */
var platform: String?

}

/// @}

// MARK:  十五，关系链变更消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十五）关系链变更消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 关系链变更消息
/// @{

class TIMSNSSystemElem: TIMElem {

/**
 * 操作类型
 */
var type: TIM_SNS_SYSTEM_TYPE?

/**
 * 被操作用户列表：TIMSNSChangeInfo 列表
 */
var users: [TIMSNSChangeInfo]?

/**
 * 未决已读上报时间戳 type = TIM_SNS_SYSTEM_PENDENCY_REPORT 有效
 */

var pendencyReportTimestamp: UInt64?

/**
 * 推荐已读上报时间戳 type = TIM_SNS_SYSTEM_RECOMMEND_REPORT 有效
 */
var recommendReportTimestamp: UInt64?

/**
 * 已决已读上报时间戳 type = TIM_SNS_SYSTEM_DECIDE_REPORT 有效
 */
var decideReportTimestamp: UInt64?

}

/// @}

// MARK:  十六，资料变更消息 Elem
/////////////////////////////////////////////////////////////////////////////////
//
//                      （十六）资料变更消息 Elem
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 资料变更消息 Elem
/// @{

class TIMProfileSystemElem: TIMElem {

/**
 *  变更类型
 */
var type: TIM_PROFILE_SYSTEM_TYPE?

/**
 *  资料变更的用户
 */
var fromUser: String?

/**
 *  资料变更的昵称（暂未实现）
 */
var nickName: String?

}


