//
//  TUIURLMessageCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/16.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class TUIURLMessageCellData: TUIBubbleMessageCellData {
    
    var title: String?
    var titleFont: NSFont
    var titleColor: NSColor
    private(set) lazy var titleAttributedString: NSAttributedString = formatTitleMessage(self.title)
    private(set) var titleSize: CGSize = .zero
    private(set) var titleOrigin: CGPoint = .zero
    
    var detail: String?
    var detailFont: NSFont
    var detailColor: NSColor
    private(set) lazy var detailAttributedString: NSAttributedString = formatDetailMessage(self.detail)
    private(set) var detailSize: CGSize = .zero
    private(set) var detailOrigin: CGPoint = .zero
    
    var image: String?
    private(set) var imageSize: CGSize = .zero
    private(set) var imageOrigin: CGPoint = .zero
    
    private(set) lazy var imageURL: URL? = {
        guard let image = image else {
            return nil
        }
        return URL(string: image)
    }()
    
    static var titleColor = NSColor.black
    static var titleFont = NSFont.systemFont(ofSize: 16)
    static var detailColor = NSColor.black
    static var detailFont = NSFont.systemFont(ofSize: 16)

    
    // MARK: Initialize
    override init(direction: MsgDirection) {
        self.titleColor = type(of: self).titleColor
        self.titleFont = type(of: self).titleFont
        self.detailFont = type(of: self).detailFont
        self.detailColor = type(of: self).detailColor
        super.init(direction: direction)
        if direction == .incoming {
            self.cellLayout = TUIMessageCellLayout.incommingTextMessageLayout
        } else {
            self.cellLayout = TUIMessageCellLayout.outgoingTextMessageLayout
        }
    }

    override func contentSize() -> CGSize {
        
        let titleRect: CGRect = titleAttributedString.boundingRect(with: CGSize(width: TURLMessageCell_Title_Width_Max, height: TURLMessageCell_Title_Height_Max), options: [.usesLineFragmentOrigin, .usesFontLeading])
        
        let detailRect: CGRect = titleAttributedString.boundingRect(with: CGSize(width: TURLMessageCell_Detail_Width_Max, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading])
        
        let titleSize: CGSize = CGSize(width: ceil(titleRect.size.width), height: ceil(titleRect.size.height))
        
        self.titleSize = titleSize
        
        let detailSize = CGSize(width: ceil(detailRect.size.width), height: ceil(detailRect.size.height))
        self.detailSize = detailSize
        
        let title_detail_margin: CGFloat = 10
        self.detailOrigin = CGPoint(x: cellLayout.bubbleInsets.left, y: cellLayout.bubbleInsets.top + self.bubbleTop)
        
        self.titleOrigin = CGPoint(x: cellLayout.bubbleInsets.left, y: self.detailOrigin.y + detailRect.height + title_detail_margin)
        
        let image_right_margin: CGFloat = 10
        self.imageSize = TURLMessageCell_Image_Size
        self.imageOrigin = CGPoint(x: TURLMessageCell_Title_Width_Max - image_right_margin - TURLMessageCell_Image_Size.width, y: self.detailOrigin.y)
        
        var size = CGSize(width: TURLMessageCell_Title_Width_Max, height: (titleSize.height + self.imageSize.height + title_detail_margin))
        size.height += cellLayout.bubbleInsets.top + cellLayout.bubbleInsets.bottom;
        size.width += cellLayout.bubbleInsets.left + cellLayout.bubbleInsets.right;
        
        if (self.direction == .incoming) {
            size.height = max(size.height, TUIBubbleMessageCellData.incommingBubble?.size.height ?? 0);
        } else {
            size.height = max(size.height, TUIBubbleMessageCellData.outgoingBubble?.size.height ?? 0);
        }
        
        return size;
    }
    
    func formatTitleMessage(_ title: String?) -> NSAttributedString {
        
        guard let title = title, title.count > 0 else {
            debugPrint("TTextMessageCell formatMessageString failed , current text is nil");
            return NSMutableAttributedString(string: "")
        }
        
        let attributeString = NSMutableAttributedString(string: title)
        attributeString.addAttribute(NSAttributedString.Key.font, value: self.titleFont, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func formatDetailMessage(_ detail: String?) -> NSAttributedString {
        
        guard let detail = detail, detail.count > 0 else {
            debugPrint("TTextMessageCell formatMessageString failed , current text is nil");
            return NSMutableAttributedString(string: "")
        }
        
        let attributeString = NSMutableAttributedString(string: detail)
        attributeString.addAttribute(NSAttributedString.Key.font, value: self.detailFont, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
}
