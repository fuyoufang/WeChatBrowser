//
//  TUITextMessageCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

/******************************************************************************
 *
 *  本文件声明了 TUITextMessageCellData 类。
 *  本类继承于 TUIBubbleMessageCellData，用于存放文本消息单元所需的一系列数据与信息。
 *
 ******************************************************************************/

/**
 * 【模块名称】TUITextMessageCellData
 * 【功能说明】文本消息单元数据源。
 *  文本消息单元，即在多数信息收发情况下最常见的消息单元。
 *  文本消息单元数据源则是为文本消息单元提供一系列所需的数据与信息。
 *  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
 */
class TUITextMessageCellData: TUIBubbleMessageCellData {
    
    /**
     *  消息的文本内容
     */
    var content: String?
    
    /**
     *  文本字体
     *  文本消息显示时的 UI 字体。
     */
    var textFont: NSFont
    
    /**
     *  文本颜色
     *  文本消息显示时的 UI 颜色。
     */
    var textColor: NSColor
    
    /**
     *  可变字符串
     *  文本消息接收到 content 字符串后，需要将字符串中可能存在的字符串表情（比如[微笑]），转为图片表情。
     *  本字符串则负责存储上述过程转换后的结果。
     */
    var _attributedString: NSAttributedString?
    var attributedString: NSAttributedString {
        get {
            if _attributedString == nil {
                _attributedString = formatMessage(self.content)
            }
            return _attributedString!
        }
    }
    
    /**
     *  文本内容尺寸。
     *  配合原点定位文本消息。
     */
    private(set) var textSize: CGSize = .zero
    
    /**
     *  文本内容原点。
     *  配合尺寸定位文本消息。
     */
    private(set) var textOrigin: CGPoint = .zero
    
    /**
     *  文本消息颜色（发送）
     *  在消息方向为发送时使用。
     */
    static var outgoingTextColor = NSColor.black
    
    /**
     *  文本消息字体（发送）
     *  在消息方向为发送时使用。
     */
    static var outgoingTextFont = NSFont.systemFont(ofSize: 16)
    
    /**
     *  文本消息颜色（接收）
     *  在消息方向为接收时使用。
     */
    static var incommingTextColor = NSColor.black
    
    /**
     *  文本消息字体（接收）
     *  在消息方向为接收时使用。
     */
    static var incommingTextFont = NSFont.systemFont(ofSize: 16)
    
    // MARK: Initialize
    override init(direction: MsgDirection) {
        if direction == .incoming {
            self.textColor = type(of: self).incommingTextColor
            self.textFont = type(of: self).incommingTextFont
        } else {
            self.textColor = type(of: self).outgoingTextColor
            self.textFont = type(of: self).outgoingTextFont
        }
        super.init(direction: direction)
        if direction == .incoming {
            self.cellLayout = TUIMessageCellLayout.incommingTextMessageLayout
        } else {
            self.cellLayout = TUIMessageCellLayout.outgoingTextMessageLayout
        }
    }
    
    override func contentSize() -> CGSize {
        return super.contentSize()
        //        CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake(TTextMessageCell_Text_Width_Max, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        //        CGSize size = CGSizeMake(CGFLOAT_CEIL(rect.size.width), CGFLOAT_CEIL(rect.size.height));
        //        self.textSize = size;
        //        self.textOrigin = CGPointMake(self.cellLayout.bubbleInsets.left, self.cellLayout.bubbleInsets.top+self.bubbleTop);
        //
        //        size.height += self.cellLayout.bubbleInsets.top+self.cellLayout.bubbleInsets.bottom;
        //        size.width += self.cellLayout.bubbleInsets.left+self.cellLayout.bubbleInsets.right;
        //
        //        if (self.direction == MsgDirectionIncoming) {
        //            size.height = MAX(size.height, [TUIBubbleMessageCellData incommingBubble].size.height);
        //        } else {
        //            size.height = MAX(size.height, [TUIBubbleMessageCellData outgoingBubble].size.height);
        //        }
        //
        //        return size;
    }
    
    func formatMessage(_ text: String?) -> NSAttributedString {
        
        guard let text = text, text.count > 0 else {
            debugPrint("TTextMessageCell formatMessageString failed , current text is nil");
            return NSMutableAttributedString(string: "")
        }
        
        //1、创建一个可变的属性字符串
        let attributeString = NSMutableAttributedString(string: text)
        //        if TUIKit.sharedInstance.config.faceGroups.count == 0 {
        attributeString.addAttribute(NSAttributedString.Key.font, value: self.textFont, range: NSMakeRange(0, attributeString.length))
        //        }
        return attributeString;
    }
    
    //    //2、通过正则表达式来匹配字符串
    //    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情
    //
    //    NSError *error = nil;
    //    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    //    if (!re) {
    //        NSLog(@"%@", [error localizedDescription]);
    //        return attributeString;
    //    }
    //
    //    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    //
    //    TFaceGroup *group = [TUIKit sharedInstance].config.faceGroups[0];
    //
    //    //3、获取所有的表情以及位置
    //    //用来存放字典，字典中存储的是图片和图片对应的位置
    //    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //    //根据匹配范围来用图片进行相应的替换
    //    for(NSTextCheckingResult *match in resultArray) {
    //        //获取数组元素中得到range
    //        NSRange range = [match range];
    //        //获取原字符串中对应的值
    //        NSString *subStr = [text substringWithRange:range];
    //
    //        for (TFaceCellData *face in group.faces) {
    //            if ([face.name isEqualToString:subStr]) {
    //                //face[i][@"png"]就是我们要加载的图片
    //                //新建文字附件来存放我们的图片,iOS7才新加的对象
    //                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    //                //给附件添加图片
    //                textAttachment.image = [[TUIImageCache sharedInstance] getFaceFromCache:face.path];
    //                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
    //                textAttachment.bounds = CGRectMake(0, -(self.textFont.lineHeight-self.textFont.pointSize)/2, self.textFont.pointSize, self.textFont.pointSize);
    //                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
    //                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    //                //把图片和图片对应的位置存入字典中
    //                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
    //                [imageDic setObject:imageStr forKey:@"image"];
    //                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
    //                //把字典存入数组中
    //                [imageArray addObject:imageDic];
    //                break;
    //            }
    //        }
    //    }
    //
    //    //4、从后往前替换，否则会引起位置问题
    //    for (int i = (int)imageArray.count -1; i >= 0; i--) {
    //        NSRange range;
    //        [imageArray[i][@"range"] getValue:&range];
    //        //进行替换
    //        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    //    }
    //
    //
    //    [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];
    //
    //    return attributeString;
}

