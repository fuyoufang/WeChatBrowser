//
//  String+TUICommon.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/14.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

extension String {
    func textSize(inSize size: CGSize, font: NSFont) -> CGSize {
        return self.textSize(inSize: size, font: font, breakMode: .byWordWrapping)
    }
    
    func textSize(inSize size: CGSize, font afont: NSFont?, breakMode: NSLineBreakMode) -> CGSize {
        return textSize(inSize: size, font: afont, breakMode: breakMode, alignment: .left)
    }
    
    func textSize(inSize size: CGSize, font afont: NSFont?, breakMode: NSLineBreakMode, alignment: NSTextAlignment) -> CGSize {
        let font = afont != nil ? afont! : NSFont.systemFont(ofSize: 14)

        var contentSize = CGSize.zero

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = breakMode
        paragraphStyle.alignment = alignment

        let attributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : paragraphStyle]
        let text = NSString(string: self)
        contentSize = text.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes).size
        contentSize = CGSize(width: Int(contentSize.width) + 1, height: Int(contentSize.height) + 1)
        return contentSize;
    }
}
