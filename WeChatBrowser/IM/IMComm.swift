//
//  IMComm.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

// MARK:  枚举类型

/**
 * 网络连接状态
 */
enum TIMNetworkStatus: Int {
    /**
     * 已连接
     */
    case CONNECTED             = 1
    /**
     * 链接断开
     */
    case DISCONNECTED          = 2
}


/**
 * 日志级别
 */
enum TIMLogLevel: Int {
    /**
     *  不输出任何 sdk log
     */
    case NONE                = 0
    /**
     *  输出 DEBUG，INFO，WARNING，ERROR 级别的 log
     */
    case DEBUG               = 3
    /**
     *  输出 INFO，WARNING，ERROR 级别的 log
     */
    case INFO                = 4
    /**
     *  输出 WARNING，ERROR 级别的 log
     */
    case WARN                = 5
    /**
     *  输出 ERROR 级别的 log
     */
    case ERROR               = 6
}

/**
 * 会话类型：
 *      C2C     双人聊天
 *      GROUP   群聊
 */
enum TIMConversationType: Int {
    /**
     *  C2C 类型
     */
    case C2C              = 1

    /**
     *  群聊 类型
     */
    case GROUP            = 2

    /**
     *  系统消息
     */
    case SYSTEM           = 3
}

/**
 *  消息状态
 */
enum IMMessageStatus: Int {
    /**
     *  消息发送中
     */
    case SENDING              = 1
    /**
     *  消息发送成功
     */
    case SEND_SUCC            = 2
    /**
     *  消息发送失败
     */
    case SEND_FAIL            = 3
    /**
     *  消息被删除
     */
    case HAS_DELETED          = 4
    /**
     *  导入到本地的消息
     */
    case LOCAL_STORED         = 5
    /**
     *  被撤销的消息
     */
    case LOCAL_REVOKED        = 6
}

/**
 *  消息优先级标识
 */
enum IMMessagePriority: Int {
    /**
     *  高优先级，一般为红包或者礼物消息
     */
    case HIGH               = 1
    /**
     *  普通优先级，普通消息
     */
    case NORMAL             = 2
    /**
     *  低优先级，一般为点赞消息
     */
    case LOW                = 3
    /**
     *  最低优先级，一般为后台下发的成员进退群通知
     */
    case LOWEST             = 4
}

/**
 *  图片压缩选项
 */
enum TIM_IMAGE_COMPRESS_TYPE: Int {
    /**
     *  原图(不压缩）
     */
    case ORIGIN              = 0x00
    /**
     *  高压缩率：图片较小，默认值
     */
    case HIGH                = 0x01
    /**
     *  低压缩：高清图发送(图片较大)
     */
    case LOW                 = 0x02
}

/**
 *  图片类型
 */
enum TIM_IMAGE_TYPE: Int {
    /**
     *  原图
     */
    case ORIGIN              = 0x01
    /**
     *  缩略图
     */
    case THUMB               = 0x02
    /**
     *  大图
     */
    case LARGE               = 0x04
}

/**
 *  图片格式
 */
enum TIM_IMAGE_FORMAT: Int {
    /**
     *  JPG 格式
     */
    case JPG            = 0x1
    /**
     *  GIF 格式
     */
    case GIF            = 0x2
    /**
     *  PNG 格式
     */
    case PNG            = 0x3
    /**
     *  BMP 格式
     */
    case BMP            = 0x4
    /**
     *  未知格式
     */
    case UNKNOWN        = 0xff
}

/**
 *  登录状态
 */
enum TIMLoginStatus: Int {
    /**
     *  已登录
     */
    case LOGINED             = 1

    /**
     *  登录中
     */
    case LOGINING            = 2

    /**
     *  无登录
     */
    case LOGOUT              = 3
}

/**
 *  推送规则
 */
enum TIMOfflinePushFlag: Int {
    /**
     *  按照默认规则进行推送
     */
    case DEFAULT    = 0
    /**
     *  不进行推送
     */
    case NO_PUSH    = 1
}

/**
 *  安卓离线推送模式
 */
enum TIMAndroidOfflinePushNotifyMode: Int {
    /**
     *  通知栏消息
     */
    case NOTIFICATION = 0x00
    /**
     *  不弹窗，由应用自行处理
     */
    case CUSTOM = 0x01
}

/**
 *  群组成员是否可见
 */
enum TIMGroupMemberVisibleType: Int {
    /**
     *  未知
     */
    case UNKNOWN          = 0x00
    /**
     *  群组成员不可见
     */
    case NO               = 0x01
    /**
     *  群组成员可见
     */
    case YES              = 0x02
}

/**
 *  群组是否能被搜到
 */
enum TIMGroupSearchableType: Int {
    /**
     *  未知
     */
    case UNKNOWN              = 0x00
    /**
     *  群组不能被搜到
     */
    case NO                   = 0x01
    /**
     *  群组能被搜到
     */
    case YES                  = 0x02
}

/**
 * 加群选项
 */
enum TIMGroupAddOpt: Int {
    /**
     *  禁止加群
     */
    case FORBID                    = 0

    /**
     *  需要管理员审批
     */
    case AUTH                      = 1

    /**
     *  任何人可以加入
     */
    case ANY                       = 2
}

/**
 *  群组提示类型
 */
enum TIMGroupTipsType: Int {
    /**
     *  成员加入
     */
    case JOIN              = 1
    /**
     *  成员离开
     */
    case QUIT              = 2
    /**
     *  成员被踢
     */
    case KICK              = 3
    /**
     *  成员设置管理员
     */
    case SET_ADMIN         = 4
    /**
     *  成员取消管理员
     */
    case CANCEL_ADMIN      = 5
}

/**
 * 群消息接受选项
 */
enum TIMGroupReceiveMessageOpt: Int {
    /**
     *  接收消息
     */
    case RECEIVE_MESSAGE                       = 0
    /**
     *  不接收消息，服务器不进行转发
     */
    case NOT_RECEIVE_MESSAGE                   = 1
    /**
     *  接受消息，不进行 iOS APNs 推送
     */
    case RECEIVE_NOT_NOTIFY_MESSAGE            = 2
}

/**
 *  群 Tips 类型
 */
enum TIM_GROUP_TIPS_TYPE: Int {
    /**
     *  邀请加入群 (opUser & groupName & userList)
     */
    case INVITE              = 0x01
    /**
     *  退出群 (opUser & groupName & userList)
     */
    case QUIT_GRP            = 0x02
    /**
     *  踢出群 (opUser & groupName & userList)
     */
    case KICKED              = 0x03
    /**
     *  设置管理员 (opUser & groupName & userList)
     */
    case SET_ADMIN           = 0x04
    /**
     *  取消管理员 (opUser & groupName & userList)
     */
    case CANCEL_ADMIN        = 0x05
    /**
     *  群资料变更 (opUser & groupName & introduction & notification & faceUrl & owner)
     */
    case INFO_CHANGE         = 0x06
    /**
     *  群成员资料变更 (opUser & groupName & memberInfoList)
     */
    case MEMBER_INFO_CHANGE         = 0x07
}

/**
 *  群变更信息 Tips 类型
 */
enum TIM_GROUP_INFO_CHANGE_TYPE: Int {
    /**
     *  群名修改
     */
    case GROUP_NAME                    = 0x01
    /**
     *  群简介修改
     */
    case GROUP_INTRODUCTION            = 0x02
    /**
     *  群公告修改
     */
    case GROUP_NOTIFICATION            = 0x03
    /**
     *  群头像修改
     */
    case GROUP_FACE                    = 0x04
    /**
     *  群主变更
     */
    case GROUP_OWNER                   = 0x05
    /**
     *  群自定义字段变更
     */
    case GROUP_CUSTOM                  = 0x06
}

/**
 *  群系统消息类型
 */
enum TIM_GROUP_SYSTEM_TYPE: Int {
    /**
     *  申请加群请求（只有管理员会收到）
     */
    case ADD_GROUP_REQUEST_TYPE              = 0x01
    /**
     *  申请加群被同意（只有申请人能够收到）
     */
    case ADD_GROUP_ACCEPT_TYPE               = 0x02
    /**
     *  申请加群被拒绝（只有申请人能够收到）
     */
    case ADD_GROUP_REFUSE_TYPE               = 0x03
    /**
     *  被管理员踢出群（只有被踢的人能够收到）
     */
    case KICK_OFF_FROM_GROUP_TYPE            = 0x04
    /**
     *  群被解散（全员能够收到）
     */
    case DELETE_GROUP_TYPE                   = 0x05
    /**
     *  创建群消息（创建者能够收到）
     */
    case CREATE_GROUP_TYPE                   = 0x06
    /**
     *  邀请入群通知(被邀请者能够收到)
     */
    case INVITED_TO_GROUP_TYPE               = 0x07
    /**
     *  主动退群（主动退群者能够收到）
     */
    case QUIT_GROUP_TYPE                     = 0x08
    /**
     *  设置管理员(被设置者接收)
     */
    case GRANT_ADMIN_TYPE                    = 0x09
    /**
     *  取消管理员(被取消者接收)
     */
    case CANCEL_ADMIN_TYPE                   = 0x0a
    /**
     *  群已被回收(全员接收)
     */
    case REVOKE_GROUP_TYPE                   = 0x0b
    /**
     *  邀请入群请求(被邀请者接收)
     */
    case INVITE_TO_GROUP_REQUEST_TYPE        = 0x0c
    /**
     *  邀请加群被同意(只有发出邀请者会接收到)
     */
    case INVITE_TO_GROUP_ACCEPT_TYPE         = 0x0d
    /**
     *  邀请加群被拒绝(只有发出邀请者会接收到)
     */
    case INVITE_TO_GROUP_REFUSE_TYPE         = 0x0e
    /**
     *  用户自定义通知(默认全员接收)
     */
    case CUSTOM_INFO                         = 0xff
}

/**
 * 群成员角色
 */
enum TIMGroupMemberRole: Int {
    /**
     *  未定义（没有获取该字段）
     */
    case UNDEFINED              = 0

    /**
     *  群成员
     */
    case ROLE_MEMBER              = 200

    /**
     *  群管理员
     */
    case ROLE_ADMIN               = 300

    /**
     *  群主
     */
    case ROLE_SUPER               = 400
}

/**
 * 群基本获取资料标志
 */
enum TIMGetGroupBaseInfoFlag: Int {
    /**
     *  不获取群组资料
     */
    case FLAG_NONE                           = 0b00
    /**
     *  获取群组名
     */
    case FLAG_NAME                           = 0b01
    /**
     *  获取创建时间
     */
    case FLAG_CREATE_TIME                    = 0b10
    /**
     *  获取群主id
     */
    case FLAG_OWNER_UIN                      = 0b100
    /**
     *  （不可用）
     */
    case FLAG_SEQ                            = 0b1_000
    /**
     *  获取最近一次修改群信息时间
     */
    case FLAG_TIME                           = 0b10_000
    /**
     *  （不可用）
     */
    case FLAG_NEXT_MSG_SEQ                   = 0b100_000
    /**
     *  获取最近一次发消息时间
     */
    case FLAG_LAST_MSG_TIME                  = 0b1_000_000
    /**
     *  （不可用）
     */
    case FLAG_APP_ID                         = 0b10_000_000
    /**
     *  获取群成员数量
     */
    case FLAG_MEMBER_NUM                     = 0b100_000_000
    /**
     *  获取最大群成员数量
     */
    case FLAG_MAX_MEMBER_NUM                 = 0b1_000_000_000
    /**
     *  获取群公告
     */
    case FLAG_NOTIFICATION                   = 0b10_000_000_000
    /**
     *  获取群简介
     */
    case FLAG_INTRODUCTION                   = 0b100_000_000_000
    /**
     *  获取群头像
     */
    case FLAG_FACE_URL                       = 0b1_000_000_000_000
    /**
     *  获取入群类型
     */
    case FLAG_ADD_OPTION                     = 0b10_000_000_000_000
    /**
     *  获取群组类型
     */
    case FLAG_GROUP_TYPE                     = 0b100_000_000_000_000
    /**
     *  获取最后一条群消息
     */
    case FLAG_LAST_MSG                       = 0b1_000_000_000_000_000
    /**
     *  获取在线人数
     */
    case FLAG_ONLINE_NUM                     = 0b10_000_000_000_000_000
    /**
     *  获取群成员是否可见标志
     */
    case VISIBLE                             = 0b100_000_000_000_000_000
    /**
     *  获取群是否能被搜到标志
     */
    case SEARCHABLE                          = 0b1_000_000_000_000_000_000
    /**
     *  获取群全员禁言时间
     */
    case ALL_SHUTUP                          = 0b10_000_000_000_000_000_000
}

/**
 *  群成员角色过滤方式
 */
enum TIMGroupMemberFilter: Int {
    /**
     *  全部成员
     */
    case ALL            = 0x00
    /**
     *  群主
     */
    case SUPER          = 0x01
    /**
     *  管理员
     */
    case ADMIN          = 0x02
    /**
     *  普通成员
     */
    case COMMON         = 0x04
}

/**
 * 群成员获取资料标志
 */
enum TIMGetGroupMemInfoFlag: Int {

    /**
     * 入群时间
     */
    case JOIN_TIME                    = 0x01
    /**
     * 消息标志
     */
    case MSG_FLAG                     = 0b10
    /**
     * 角色
     */
    case ROLE_INFO                    = 0b1000
    /**
     * 禁言时间
     */
    case SHUTUP_TIME                  = 0b10000
    /**
     * 群名片
     */
    case NAME_CARD                    = 0b100000
}

/**
 *  群组操作结果
 */
enum TIMGroupMemberStatus: Int {
    /**
     *  操作失败
     */
    case FAIL              = 0

    /**
     *  操作成功
     */
    case SUCC              = 1

    /**
     *  无效操作，加群时已经是群成员，移除群组时不在群内
     */
    case INVALID           = 2

    /**
     *  等待处理，邀请入群时等待对方处理
     */
    case PENDING           = 3
}

/**
 *  群组未决请求类型
 */
enum TIMGroupPendencyGetType: Int {
    /**
     *  申请入群
     */
    case JOIN            = 0x0
    /**
     *  邀请入群
     */
    case INVITE          = 0x1
}

/**
 *  群组已决标志
 */
enum TIMGroupPendencyHandleStatus: Int {
    /**
     *  未处理
     */
    case UNHANDLED            = 0
    /**
     *  被他人处理
     */
    case OTHER_HANDLED        = 1
    /**
     *  被用户处理
     */
    case OPERATOR_HANDLED     = 2
}

/**
 *  群组已决结果
 */
enum TIMGroupPendencyHandleResult: Int {
    /**
     *  拒绝申请
     */
    case REFUSE       = 0
    /**
     *  同意申请
     */
    case AGREE        = 1
}

/**
 * 好友验证方式
 */
enum TIMFriendAllowType: Int {
    /**
     *  同意任何用户加好友
     */
    case ALLOW_ANY                    = 0

    /**
     *  需要验证
     */
    case NEED_CONFIRM                 = 1

    /**
     *  拒绝任何人加好友
     */
    case DENY_ANY                     = 2
}

/**
 * 性别
 */
enum TIMGender: Int {
    /**
     *  未知性别
     */
    case UNKNOWN      = 0
    /**
     *  男性
     */
    case MALE         = 1
    /**
     *  女性
     */
    case FEMALE       = 2

}

/**
 * 操作类型
 */
enum TIM_SNS_SYSTEM_TYPE: Int {
    /**
     *  增加好友消息
     */
    case ADD_FRIEND                           = 0x01
    /**
     *  删除好友消息
     */
    case DEL_FRIEND                           = 0x02
    /**
     *  增加好友申请
     */
    case ADD_FRIEND_REQ                       = 0x03
    /**
     *  删除未决申请
     */
    case DEL_FRIEND_REQ                       = 0x04
    /**
     *  黑名单添加
     */
    case ADD_BLACKLIST                        = 0x05
    /**
     *  黑名单删除
     */
    case DEL_BLACKLIST                        = 0x06
    /**
     *  未决已读上报
     */
    case PENDENCY_REPORT                      = 0x07
    /**
     *  关系链资料变更
     */
    case SNS_PROFILE_CHANGE                   = 0x08
}

/**
 *  资料变更
 */
enum TIM_PROFILE_SYSTEM_TYPE: Int {
    /**
     好友资料变更
     */
    case FRIEND_PROFILE_CHANGE        = 0x01
}

// MARK:  block 回调



/**
 *  获取消息回调
 *
 *  @param msgs 消息列表
 */
//typedef void (^TIMGetMsgSucc)(NSArray * msgs);
typealias TIMGetMsgSucc = () -> [TIMMessage]

/**
 *  一般操作成功回调
 */
//typedef void (^TIMSucc)(void);
typealias TIMSucc = () -> Void

/**
 *  操作失败回调
 *
 *  @param code 错误码
 *  @param msg  错误描述，配合错误码使用，如果问题建议打印信息定位
 */
//typedef void (^TIMFail)(int code, NSString * msg);
typealias TIMFail = (_ code: Int, _ msg: String?) -> Void
/**
 *  进度毁掉
 *
 *  @param curSize 已下载大小
 *  @param totalSize  总大小
 */
//typedef void (^TIMProgress)(NSInteger curSize, NSInteger totalSize);
typealias TIMProgress = (_ cusSize: Int, _ totalSize: Int) -> Void

/**
 *  获取资源
 *
 *  @param data 资源二进制
 */
//typedef void (^TIMGetResourceSucc)(Data * data);
typealias TIMGetResourceSucc = (_ data: Data) -> Void
/**
 *  好友列表
 *
 *  @param friends 好友列表
 */
//typedef void (^TIMFriendArraySucc)(NSArray<TIMFriend *> *friends);
typealias TIMFriendArraySucc = (_ friends: [TIMFriend]) -> Void
/**
 *  获取资料回调
 *
 *  @param profile 资料
 */
//typedef void (^TIMGetProfileSucc)(TIMUserProfile * profile);
typealias TIMGetProfileSucc = (_ profile: TIMUserProfile) -> Void
/**
 *  获取资料回调
 *
 *  @param profiles 资料
 */
//typedef void (^TIMUserProfileArraySucc)(NSArray<TIMUserProfile *> *profiles);
typealias TIMUserProfileArraySucc = (_ profilse: [TIMUserProfile]) -> Void

/**
 *  好友操作回调
 *
 *  @param result 资料
 */
//typedef void (^TIMFriendResultSucc)(TIMFriendResult *result);
typealias TIMFriendResultSucc = (_ result: TIMFriendResult) -> Void
/**
 *  好友操作回调
 *
 *  @param results 资料
 */
//typedef void (^TIMFriendResultArraySucc)(NSArray<TIMFriendResult *> *results);
typealias TIMFriendResultArraySucc = (_ results: [TIMFriendResult]) -> Void

/**
 *  检查好友操作回调
 *
 *  @param results 检查结果
 */
//typedef void (^TIMCheckFriendResultArraySucc)(NSArray<TIMCheckFriendResult *> *results);

typealias TIMCheckFriendResultArraySucc = (_ results: [TIMCheckFriendResult]) -> Void
/**
 *  群成员列表回调
 *
 *  @param members 群成员列表
 */
//typedef void (^TIMGroupMemberSucc)(NSArray * members);
typealias TIMGroupMemberSucc = (_ members: [String]) -> Void
/**
 *  群列表结果回调
 *
 *  @param groupList 群列表结果
 */
//typedef void (^TIMGroupListSucc)(NSArray* groupList);
typealias TIMGroupListSucc = (_ groupList: [String]) -> Void
/**
 *  本人群组内成员信息回调
 *
 *  @param selfInfo 本人成员信息
 */
typealias TIMGroupSelfSucc = (_ selfInfo: TIMGroupMemberInfo) -> Void

/**
 *  群接受消息选项回调
 *
 *  @param opt 群接受消息选项
 */
typealias TIMGroupReciveMessageOptSucc = (_ opt: TIMGroupReceiveMessageOpt) -> Void

/**
 *  群成员列表回调（分页使用）
 *
 *  @param members 群成员（TIMGroupMemberInfo*）列表
 */
typealias TIMGroupMemberSuccV2 = (_ nextSeq: UInt64, _ members: [TIMGroupMemberInfo]) -> Void

/**
 *  群搜索回调
 *
 *  @param totalNum 搜索结果的总数
 *  @param groups  请求的群列表片段
 */
typealias TIMGroupSearchSucc = (_ totalNum: UInt64, _ groups: [TIMGroupMemberInfo]) -> Void


// MARK:  基本类型

/// 实现 NSCoding 协议
class TIMCodingModel {

///读取实例变量，并把这些数据写到 coder 中去，序列化数据
//- (void)encodeWithCoder:(NSCoder *)encoder;

///从 coder 中读取数据，保存到相应的变量中，即反序列化数据
//- (id)initWithCoder:(NSCoder *)decoder;

}


/// 设置用户配置信息
class TIMUserConfig {

///禁用本地存储（AVChatRoom,BChatRoom 消息数量很大，出于程序性能的考虑，默认不存本地）
 var disableStorage: Bool?

///默认情况下，出于性能考虑，当用户在终端 A 收到未读消息后，Server 默认会删除未读消息，但如果用户切换到终端 B 后，IM SDK 无法再同步到未读消息，未读计数也不会增加，如果需要在终端 B 下也有未读，请设置 disableAutoReport 为 YES，这个时候 Server 不会再主动删除未读消息。注意一旦这这样设置，开发者需要主动调用 TIMConversation.h -> setReadMessage ，否则未读消息会一直存在 Server，IM SDK 每次登录或则断网重连都会再次同步到未读消息，详情请参考官方文档 [自动已读上报](https://cloud.tencent.com/document/product/269/9151)。
 var disableAutoReport: Bool?

///已读回执是自己发出去的消息，对方设置为已读后，自己能收到已读的回调，只针对单聊（C2C）会话生效，默认是关闭的，如果需要开启，请设置 enableReadReceipt 为 YES，收到消息的用户需要显式调用 TIMConversation.h -> setReadMessage，发消息的用户才能通过 IMMessageReceiptListener 监听到消息的已读回执。
 var enableReadReceipt: Bool?

///设置默认拉取的群组资料,如果想要拉取自定义字段，要通过 [IM 控制台](https://console.cloud.tencent.com/avc) -> 功能配置 -> 群维度自定义字段配置对应的 "自定义字段" 和用户操作权限，控制台配置之后 5 分钟后才会生效。
var groupInfoOpt: TIMGroupInfoOption?

///设置默认拉取的群成员资料,如果想要拉取自定义字段，要通过 [IM 控制台](https://console.cloud.tencent.com/avc) -> 功能配置 -> 群成员维度自定义字段配置对应的 "自定义字段" 和用户操作权限，控制台配置之后 5 分钟后才会生效。
var groupMemberInfoOpt: TIMGroupMemberInfoOption?

///关系链参数
var friendProfileOpt: TIMFriendProfileOption?

}

/// 消息定位
class IMMessageLocator {

///所属会话的 id
var sessId: String?

///所属会话的类型
 var sessType:TIMConversationType?

///消息序列号
 var seq: UInt64?

///消息随机码
 var rand: UInt64?

///消息时间戳
 var time:time_t?

///是否本人消息
 var isSelf: Bool?

///是否来自撤销通知
 var isFromRevokeNotify: Bool?

}


/// 群组内的本人信息
class TIMGroupSelfInfo {

///加入群组时间
 var joinTime: UInt32?

///群组中的角色
 var role:TIMGroupMemberRole?

///群组消息接收选项
 var recvOpt:TIMGroupReceiveMessageOpt?

///群组中的未读消息数
 var unReadMessageNum: UInt32?

}

/// 群资料信息
class TIMGroupInfo: TIMCodingModel {

///群组 Id
var group: String?

///群名
var groupName: String?

///群创建人/管理员
var owner: String?

///群类型：Private,Public,ChatRoom
var groupType: String?

///群创建时间
 var createTime: UInt32?

///最近一次群资料修改时间
 var lastInfoTime: UInt32?

///最近一次发消息时间
 var lastMsgTime: UInt32?

///最大成员数
 var maxMemberNum: UInt32?

///群成员数量
 var memberNum: UInt32?

///入群类型
 var addOpt: TIMGroupAddOpt?

///群公告
var notification: String?

///群简介
var introduction: String?

///群头像
var faceURL: String?

///最后一条消息
var lastMsg: TIMMessage?

///在线成员数量
 var onlineMemberNum: UInt32 = 0

///群组是否被搜索类型
 var isSearchable: TIMGroupSearchableType?

///群组成员可见类型
 var isMemberVisible: TIMGroupMemberVisibleType?

///是否全员禁言
 var allShutup: Bool?

///群组中的本人信息
var selfInfo: TIMGroupSelfInfo?

///自定义字段集合,key 是 NSString* 类型,value 是 Data* 类型
    var customInfo: [String : Data]?

}

/// 获取群组信息结果
class TIMGroupInfoResult: TIMGroupInfo {

/// 结果 0：成功；非0：失败
 var resultCode: Int?

/// 结果信息
var resultInfo: String?
}

/// 获取某个群组资料
class TIMGroupInfoOption {

///需要获取的群组信息标志（TIMGetGroupBaseInfoFlag）,默认为0xffffff
 var groupFlags: UInt64?

}

/// 需要某个群成员资料
class TIMGroupMemberInfoOption {

///需要获取的群成员标志（TIMGetGroupMemInfoFlag）,默认为0xffffff
 var memberFlags: UInt64?

}

/// 群成员资料
class TIMGroupMemberInfo: TIMCodingModel {

///成员
var member: String?

///群名片
var nameCard: String?

///加入群组时间
 var joinTime:time_t?

///成员类型
 var role:TIMGroupMemberRole?

///禁言结束时间（时间戳）
 var silentUntil: UInt32?

///自定义字段集合,key 是 NSString*类型,value 是 Data*类型
    var customInfo: [String : Data]?

///如果是自己，可以获取自己的群接收选项
 var receiveMessageOpt: TIMGroupReceiveMessageOpt?

}

///资料与关系链
class TIMFriendProfileOption {

///关系链最大缓存时间(默认缓存一天；获取资料和关系链超过缓存时间，将自动向服务器发起请求)
    var expiredSeconds: Int = 0

}

///用户资料
class TIMUserProfile: TIMCodingModel {

/**
 *  用户 identifier
 */
var identifier: String?

/**
 *  用户昵称
 */
var nickname: String?

/**
 *  好友验证方式
 */
 var allowType: TIMFriendAllowType?

/**
 * 用户头像
 */
var faceURL: String?

/**
 *  用户签名
 */
var selfSignature: Data?

/**
 *  用户性别
 */
    var gender: TIMGender = .UNKNOWN

/**
 *  用户生日
 */
 var birthday: UInt32 = 0

/**
 *  用户区域
 */
var location: Data?

/**
 *  用户语言
 */
 var language: UInt32?

/**
 *  等级
 */
 var level: UInt32?

/**
 *  角色
 */
 var role: UInt32?

/**
 *  自定义字段集合,key是NSString类型,value是Data类型或者NSNumber类型
 *  key值按照后台配置的字符串传入,不包括 TIMProfileTypeKey_Custom_Prefix 前缀
 */
    var customInfo: [String : Data]?

}

typealias ProfileCallBack = (_ profile: TIMUserProfile) -> Void

/**
 *  好友
 */
class TIMFriend: TIMCodingModel {

/**
 *  好友identifier
 */
var identifier: String?

/**
 *  好友备注（最大96字节，获取自己资料时，该字段为空）
 */
var remark: String?

/**
 *  分组名称 NSString* 列表
 */
var groups: [String]?

/**
 *  申请时的添加理由
 */
var addWording: String?

/**
 *  申请时的添加来源
 */
var addSource: String?

/**
 * 添加时间
 */
 var addTime: UInt64?

/**
 *  自定义字段集合,key是NSString类型,value是Data类型或者NSNumber类型
 *  key值按照后台配置的字符串传入,不包括 TIMFriendTypeKey_Custom_Prefix 前缀
 */
    var customInfo: [String : Data]?

/**
 * 好友资料
 */
var profile: TIMUserProfile?

}

/**
 *  创建群参数
 */
class TIMCreateGroupInfo: TIMCodingModel {

/**
 *  群组Id,nil则使用系统默认Id
 */
var group: String?

/**
 *  群名
 */
var groupName: String?

/**
 *  群类型：Private,Public,ChatRoom,AVChatRoom,BChatRoom
 */
var groupType: String?

/**
 *  是否设置入群选项，Private类型群组请设置为false
 */
var setAddOpt: Bool?

/**
 *  入群选项
 */
 var addOpt: TIMGroupAddOpt?

/**
 *  最大成员数，填0则系统使用默认值
 */

 var maxMemberNum: UInt32?

/**
 *  群公告
 */
var notification: String?

/**
 *  群简介
 */
var introduction: String?

/**
 *  群头像
 */
var faceURL: String?

/**
 *  自定义字段集合,key是NSString*类型,value是Data*类型
 */
var customInfo: [String : Data]?

/**
 *  创建成员（TIMCreateGroupMemberInfo*）列表
 */
var membersInfo: [TIMCreateGroupMemberInfo]?

}

/**
 * 未决请求选项
 */
class TIMGroupPendencyOption: TIMCodingModel {

/**
 *  拉取的起始时间 0：拉取最新的
 */
 var timestamp: UInt64?

/**
 *  每页的数量，最大值为 10，设置超过 10，也最多只能拉回 10 条未决
 */
 var numPerPage: UInt32?
}

/**
 *  未决请求元信息
 */
class TIMGroupPendencyMeta: TIMCodingModel {

/**
 *  下一次拉取的起始时间戳
 */
 var nextStartTime: UInt64?

/**
 *  已读时间戳大小
 */
 var readTimeSeq: UInt64?

/**
 *  未决未读数
 */
 var unReadCnt: UInt32?

}

/**
 *  创建群组时的成员信息
 */
class TIMCreateGroupMemberInfo: TIMCodingModel {

/**
 *  被操作成员
 */
var member: String?

/**
 *  成员类型
 */
 var role:TIMGroupMemberRole?

/**
 *  自定义字段集合,key是NSString*类型,value是Data*类型
 */
    var customInfo: [String : Data]?

}

/**
 *  成员操作返回值
 */
class TIMGroupMemberResult {

/**
 *  被操作成员
 */
var member: String?
/**
 *  返回状态
 */
 var status: TIMGroupMemberStatus?

}

/**
 *  未决申请
 */
class TIMGroupPendencyItem: TIMCodingModel {

/**
 *  相关群组id
 */
var groupId: String?

/**
 *  请求者id，请求加群:请求者，邀请加群:邀请人
 */
var fromUser: String?

/**
 *  判决者id，请求加群:0，邀请加群:被邀请人
 */
var toUser: String?

/**
 *  未决添加时间
 */
 var addTime: UInt64?

/**
 *  未决请求类型
 */
 var getType:TIMGroupPendencyGetType?

/**
 *  已决标志
 */
 var handleStatus:TIMGroupPendencyHandleStatus?

/**
 *  已决结果
 */
 var handleResult:TIMGroupPendencyHandleResult?

/**
 *  申请或邀请附加信息
 */
var requestMsg: String?

/**
 *  审批信息：同意或拒绝信息
 */
var handledMsg: String?

/**
 *  用户自己的id
 */
var selfIdentifier: String?

}

/**
 *  关系链变更详细信息
 */
class TIMSNSChangeInfo {

/**
 *  用户 identifier
 */
var identifier: String?

/**
 *  用户昵称
 */
var nickname: String?

/**
 *  申请添加时有效，添加理由
 */
var wording: String?

/**
 *  申请时填写，添加来源
 */
var source: String?


/**
 *  备注 type=SNS_PROFILE_CHANGE 有效
 */
var remark: String?

}
