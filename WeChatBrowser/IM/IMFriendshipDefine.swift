//
//  IMFriendshipDefine.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

// MARK:  block回调

/**
 * 获取未决请求列表成功
 *
 *  @param pendencyResponse 未决请求元信息
 */
//typedef void (^TIMGetFriendPendencyListSucc)(TIMFriendPendencyResponse *pendencyResponse);
//
///**
// *  群搜索回调
// *
// *  @param totalNum 搜索结果的总数
// *  @param users    请求的用户列表片段
// */
//typedef void (^TIMUserSearchSucc)(uint64_t totalNum, NSArray * users);
//
///**
// *  好友分组列表
// *
// *  @param groups 好友分组（TIMFriendGroup*)列表
// */
typealias TIMFriendGroupArraySucc = (_ groups: [TIMFriendGroup]) -> Void
//
///**
// *  好友关系检查回调
// *
// *  @param results TIMCheckFriendResult列表
// */
//typedef void (^TIMFriendCheckSucc)(NSArray* results);
//

// MARK:  枚举类型

/**
 * 好友操作状态
 *
 * 详细错误码参见 https://cloud.tencent.com/document/product/269/1671#.E5.85.B3.E7.B3.BB.E9.93.BE.E9.94.99.E8.AF.AF.E7.A0.81
 */
enum TIMFriendStatus: Int {
    /**
     *  操作成功
     */
    case FRIEND_STATUS_SUCC                              = 0
    
    /**
     *  请求参数错误，请根据错误描述检查请求是否正确
     */
    case FRIEND_PARAM_INVALID                                = 30001
    
    /**
     *  请求参数错误，SdkAppid 不匹配。
     */
    case FRIEND_SDK_APPID_INVALID                            = 30002
    
    /**
     *  请求的用户帐号不存在
     */
    case FRIEND_ID_INVALID                                   = 30003
    
    /**
     *  请求需要 App 管理员权限
     */
    case FRIEND_NEED_ADMIN_PERMISSON                         = 30004
    
    /**
     *  关系链字段中包含敏感词
     */
    case FRIEND_DIRTY_WORD                                   = 30005
    
    /**
     *  服务器内部错误，请重试
     */
    case FRIEND_SERVER_ERROR                                 = 30006
    
    /**
     *  网络超时，请稍后重试
     */
    case FRIEND_TIMEOUT                                      = 30007
    
    /**
     *  并发写导致写冲突，建议使用批量方式
     */
    case FRIEND_WRITE_ERROR                                  = 30008
    
    /**
     *  后台禁止该用户发起加好友请求
     */
    case ADD_FRIEND_FORBIDEN                                 = 30009
    
    /**
     *  自己的好友数已达系统上限
     */
    case ADD_FRIEND_STATUS_SELF_FRIEND_FULL                  = 30010
    
    /**
     * 分组已达系统上限
     */
    case UPDATE_FRIEND_GROUP_STATUS_MAX_GROUPS_EXCEED        = 30011
    
    /**
     * 未决数已达系统上限。
     */
    case PENDENCY_STATUS_FULL                                = 30012
    
    /**
     * 黑名单数已达系统上限
     */
    case ADD_BLACKLIST_STATUS_FULL                           = 30013
    
    /**
     *  对方的好友数已达系统上限
     */
    case ADD_FRIEND_STATUS_THEIR_FRIEND_FULL                 = 30014
    
    /**
     *  被加好友在自己的黑名单中
     */
    case ADD_FRIEND_STATUS_IN_SELF_BLACK_LIST                = 30515
    
    /**
     *  被加好友设置为禁止加好友
     */
    case ADD_FRIEND_STATUS_FRIEND_SIDE_FORBID_ADD            = 30516
    
    /**
     *  已被被添加好友设置为黑名单
     */
    case ADD_FRIEND_STATUS_IN_OTHER_SIDE_BLACK_LIST          = 30525
    
    /**
     *  等待好友审核同意
     */
    case ADD_FRIEND_STATUS_PENDING                           = 30539
    
    /**
     *  添加好友请求被安全策略打击，请勿频繁发起添加好友请求
     */
    case ADD_FRIEND_STATUS_SENSITIVE                         = 30540
    
    /**
     *  对方没有申请过好友
     */
    case RESPONSE_FRIEND_STATUS_NO_REQ                       = 30614
    
    /**
     *  删除好友请求被安全策略打击，请勿频繁发起删除好友请求
     */
    case DELETE_FRIEND_STATUS_SENSITIVE                      = 31707
};

enum TIMDelFriendType: Int {
    /**
     *  删除单向好友
     */
    case FRIEND_DEL_SINGLE               = 1
    
    /**
     *  删除双向好友
     */
    case FRIEND_DEL_BOTH                 = 2
};

enum TIMPendencyType: Int {
    /**
     *  别人发给我的
     */
    case PENDENCY_COME_IN                    = 1
    
    /**
     *  我发给别人的
     */
    case PENDENCY_SEND_OUT                   = 2
    
    /**
     * 别人发给我的 和 我发给别人的。仅拉取时有效
     */
    case PENDENCY_BOTH                       = 3
};

/**
 * 推荐好友类型
 */
enum TIMFutureFriendType: Int {
    /**
     *  收到的未决请求
     */
    case PENDENCY_IN_TYPE              = 0x1
    
    /**
     *  发出去的未决请求
     */
    case PENDENCY_OUT_TYPE             = 0x2
    
    /**
     *  推荐好友
     */
    case RECOMMEND_TYPE                = 0x4
    
    /**
     *  已决好友
     */
    case DECIDE_TYPE                   = 0x8
};

/**
 * 翻页选项
 */
enum TIMPageDirectionType: Int {
    /**
     *  向上翻页
     */
    case UP_TYPE            = 1
    
    /**
     *  向下翻页
     */
    case DOWN_TYPE           = 2
};

/**
 *  好友检查类型
 */
enum TIMFriendCheckType: Int {
    /**
     *  单向好友
     */
    case UNIDIRECTION     = 0x1
    /**
     *  互为好友
     */
    case BIDIRECTION      = 0x2
};

/**
 *  好友关系类型
 */
enum TIMFriendRelationType: Int {
    /**
     *  不是好友
     */
    case NONE           = 0x0
    /**
     *  对方在我的好友列表中
     */
    case MY_UNI         = 0x1
    /**
     *  我在对方的好友列表中
     */
    case OTHER_UNI      = 0x2
    /**
     *  互为好友
     */
    case BOTHWAY        = 0x3
};

enum TIMFriendResponseType: Int {
    /**
     *  同意加好友（建立单向好友）
     */
    case AGREE                       = 0
    
    /**
     *  同意加好友并加对方为好友（建立双向好友）
     */
    case AGREE_AND_ADD               = 1
    
    /**
     *  拒绝对方好友请求
     */
    case REJECT                      = 2
};

/**
 *  好友检查类型
 */
enum TIMFriendAddType: Int {
    /**
     *  单向好友
     */
    case SINGLE     = 1
    /**
     *  互为好友
     */
    case BOTH       = 2
};

// MARK:  基本类型

/**
 *  加好友请求
 */
class TIMFriendRequest: TIMCodingModel {
    
    /**
     *  用户identifier（必填）
     */
    
    var identifier: String?
    
    /**
     *  备注（备注最大96字节）
     */
    var remark: String?
    
    /**
     *  请求说明（最大120字节）
     */
    var addWording: String?
    
    /**
     *  添加来源
     *  来源需要添加“AddSource_Type_”前缀
     */
    var addSource: String?
    
    /**
     *  分组
     */
    var group: String?
    
    
    /**
     *  加好友方式 (可选)
     */
    var addType: TIMFriendAddType?
    
}

/**
 * 未决请求
 */
class TIMFriendPendencyItem: TIMCodingModel {
    
    /**
     * 用户标识
     */
    var identifier: String?
    /**
     * 增加时间
     */
    
    var addTime: UInt64 = 0
    /**
     * 来源
     */
    var addSource: String?
    /**
     * 加好友附言
     */
    var addWording: String?
    
    /**
     * 加好友昵称
     */
    var nickname: String?
    
    /**
     * 未决请求类型
     */
    var type: TIMPendencyType?
    
}

/**
 * 未决推送
 */
class TIMFriendPendencyInfo: TIMCodingModel {
    /**
     * 用户标识
     */
    var identifier: String?
    /**
     * 来源
     */
    var addSource: String?
    /**
     * 加好友附言
     */
    var addWording: String?
    
    /**
     * 加好友昵称
     */
    var nickname: String?
}

/**
 * 未决请求信息
 */
class TIMFriendPendencyRequest: TIMCodingModel {
    
    /**
     * 序列号，未决列表序列号
     *    建议客户端保存seq和未决列表，请求时填入server返回的seq
     *    如果seq是server最新的，则不返回数据
     */
    var seq: UInt64?
    
    /**
     * 翻页时间戳，只用来翻页，server返回0时表示没有更多数据，第一次请求填0
     *    特别注意的是，如果server返回的seq跟填入的seq不同，翻页过程中，需要使用客户端原始seq请求，直到数据请求完毕，才能更新本地seq
     */
    var timestamp: UInt64 = 0
    
    /**
     * 每页的数量，即本次请求最多返回多个数据，最大不超过 100，设置太大一次请求回包的时间会过长。默认值100
     * 注意：后台最多只保存100条未决
     */
    var numPerPage: UInt64 = 0
    
    /**
     * 未决请求拉取类型
     */
    var type: TIMPendencyType?
    
}

/**
 * 未决返回信息
 */
class TIMFriendPendencyResponse: TIMCodingModel {
    
    /**
     * 本次请求的未决列表序列号
     */
    var seq: UInt64?
    
    /**
     * 本次请求的翻页时间戳
     */
    var timestamp: UInt64?
    
    /**
     * 未决请求未读数量
     */
    var unreadCnt: UInt64?
    
    /**
     * 未决数据
     */
    var pendencies: [TIMFriendPendencyItem]?
}

/**
 *  好友分组信息
 */
class TIMFriendGroup: TIMCodingModel {
    /**
     *  好友分组名称
     */
    var name: String?
    
    /**
     *  分组成员数量
     */
    var userCnt: UInt64 = 0
    
    /**
     *  分组成员identifier列表
     */
    var friends: [String]?
    
}

/**
 *  好友关系检查
 */
struct TIMFriendCheckInfo {
    /**
     *  检查用户的id列表（NSString*）
     */
    var users: [String]?
    
    /**
     *  检查类型
     */
    var checkType: TIMFriendCheckType
    
}

struct TIMCheckFriendResult {
    /**
     *  用户id
     */
    var identifier: String?
    
    /**
     * 返回码
     */
    var result_code: Int?
    
    /**
     * 返回信息
     */
    var result_info: String?
    
    /**
     *  检查结果
     */
    var resultType: TIMFriendRelationType
    
}

class TIMFriendResult {
    
    /**
     *  用户Id
     */
    var identifier: String?
    
    /**
     * 返回码
     */
    var result_code: Int?
    
    /**
     * 返回信息
     */
    var result_info: String?
    
}

/**
 * 响应好友请求
 */
class TIMFriendResponse {
    
    /**
     *  响应类型
     */
    var responseType: TIMFriendResponseType?
    
    /**
     *  用户identifier
     */
    var identifier: String?
    
    /**
     *  备注好友（可选，如果要加对方为好友）。备注最大96字节
     */
    var remark: String?
    
}


/**
 *  好友分组信息扩展
 */
class TIMFriendGroupWithProfiles: TIMFriendGroup {
    /**
     *  好友资料（*）列表
     */
    var profiles: [TIMUserProfile]?
}

// 用户资料KEY

/**
 * 昵称
 * 值类型: NSString
 */
let TIMProfileTypeKey_Nick = "TIMProfileTypeKey_Nick";
/**
 * 头像
 * 值类型: NSString
 */
let TIMProfileTypeKey_FaceUrl = "TIMProfileTypeKey_FaceUrl";
/**
 * 好友申请
 * 值类型: NSNumber [TIM_FRIEND_ALLOW_ANY,TIM_FRIEND_NEED_CONFIRM,TIM_FRIEND_DENY_ANY]
 */
let TIMProfileTypeKey_AllowType = "TIMProfileTypeKey_AllowType";
/**
 * 性别
 * 值类型: NSNumber [TIM_GENDER_UNKNOWN,TIM_GENDER_MALE,TIM_GENDER_FEMALE]
 */
let TIMProfileTypeKey_Gender = "TIMProfileTypeKey_Gender";
/**
 * 生日
 * 值类型: NSNumber
 */
let TIMProfileTypeKey_Birthday = "TIMProfileTypeKey_Birthday";
/**
 * 位置
 * 值类型: NSString
 */
let TIMProfileTypeKey_Location = "TIMProfileTypeKey_Location";
/**
 * 语言
 * 值类型: NSNumber
 */
let TIMProfileTypeKey_Language = "TIMProfileTypeKey_Language";
/**
 * 等级
 * 值类型: NSNumber
 */
let TIMProfileTypeKey_Level = "TIMProfileTypeKey_Level";
/**
 * 角色
 * 值类型: NSNumber
 */
let TIMProfileTypeKey_Role = "TIMProfileTypeKey_Role";
/**
 * 签名
 * 值类型: NSString
 */
let TIMProfileTypeKey_SelfSignature = "TIMProfileTypeKey_SelfSignature";
/**
 * 自定义字段前缀
 * 值类型: [NSString,Data|NSNumber]
 * @note 当设置自定义字的值NSString对象时，后台会将其转为UTF8保存在数据库中。由于部分用户迁移资料时可能不是UTF8类型，所以在获取资料时，统一返回Data类型。
 */
let TIMProfileTypeKey_Custom_Prefix = "TIMProfileTypeKey_Custom_Prefix";

// 好友资料KEY

/**
 * 备注
 * 值类型: NSString
 */
let TIMFriendTypeKey_Remark = "TIMFriendTypeKey_Remark";
/**
 * 分组
 * 值类型: [NSArray]
 */
let TIMFriendTypeKey_Group = "TIMFriendTypeKey_Group";
/**
 * 自定义字段前缀
 * 值类型: [NSString,Data|NSNumber]
 */
let TIMFriendTypeKey_Custom_Prefix = "TIMFriendTypeKey_Custom_Prefix";


