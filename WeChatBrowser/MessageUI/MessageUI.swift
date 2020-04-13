//
//  MessageUI.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

let DefaultAvatarImage = TUIKit.sharedInstance().config.defaultAvatarImage

let DefaultGroupAvatarImage = TUIKit.sharedInstance().config.defaultGroupAvatarImage

let TConversationCell_Height: CGFloat = 72




////cell
//#define TMessageCell_Head_Width 45
//#define TMessageCell_Head_Height 45
//#define TMessageCell_Head_Size CGSizeMake(45, 45)
//#define TMessageCell_Padding 8
//#define TMessageCell_Margin 8
//#define TMessageCell_Indicator_Size CGSizeMake(20, 20)
//
////text cell
//#define TTextMessageCell_Height_Min (TMessageCell_Head_Size.height + 2 * TMessageCell_Padding)
//#define TTextMessageCell_Text_PADDING (160)
//#define TTextMessageCell_Text_Width_Max (Screen_Width - TTextMessageCell_Text_PADDING)
//#define TTextMessageCell_Margin 12
//
////system cell
//#define TSystemMessageCell_Background_Color RGBA(215, 215, 215, 1.0)
//#define TSystemMessageCell_Text_Width_Max (Screen_Width * 0.5)
//#define TSystemMessageCell_Margin 5
//
////joinGroup cell 继承自 system cell
//#define TJoinGroupMessageCell_Background_Color RGBA(215, 215, 215, 1.0)
//#define TJoinGroupMessageCell_Text_Width_Max (Screen_Width * 0.5)
//#define TJoinGroupMessageCell_Margin 5
//
//
////image cell
//#define TImageMessageCell_Image_Width_Max (Screen_Width * 0.4)
//#define TImageMessageCell_Image_Height_Max TImageMessageCell_Image_Width_Max
//#define TImageMessageCell_Margin_2 8
//#define TImageMessageCell_Margin_1 16
//#define TImageMessageCell_Progress_Color  RGBA(0, 0, 0, 0.5)
//
////face cell
//#define TFaceMessageCell_Image_Width_Max (Screen_Width * 0.25)
//#define TFaceMessageCell_Image_Height_Max TFaceMessageCell_Image_Width_Max
//#define TFaceMessageCell_Margin 16
//
////file cell
//#define TFileMessageCell_Container_Size CGSizeMake((Screen_Width * 0.5), (Screen_Width * 0.15))
//#define TFileMessageCell_Margin 10
//#define TFileMessageCell_Progress_Color  RGBA(0, 0, 0, 0.5)
//
////video cell
//#define TVideoMessageCell_Image_Width_Max (Screen_Width * 0.4)
//#define TVideoMessageCell_Image_Height_Max TVideoMessageCell_Image_Width_Max
//#define TVideoMessageCell_Margin_3 4
//#define TVideoMessageCell_Margin_2 8
//#define TVideoMessageCell_Margin_1 16
//#define TVideoMessageCell_Play_Size CGSizeMake(35, 35)
//#define TVideoMessageCell_Progress_Color  RGBA(0, 0, 0, 0.5)
//
////voice cell
//#define TVoiceMessageCell_Max_Duration 60.0
//#define TVoiceMessageCell_Height TMessageCell_Head_Size.height
//#define TVoiceMessageCell_Margin 12
//#define TVoiceMessageCell_Back_Width_Max (Screen_Width * 0.4)
//#define TVoiceMessageCell_Back_Width_Min 60
//#define TVoiceMessageCell_Duration_Size CGSizeMake(33, 33)
