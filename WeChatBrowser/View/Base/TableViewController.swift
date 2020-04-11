//
//  TableViewController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class TableViewController: NSViewController {
    
    // MARK: - UI
    
    lazy var tableView: TableView = {
        let v = TableView()
        
        // We control the intial selection during initialization
        v.allowsEmptySelection = true
        v.wantsLayer = true
        v.focusRingType = .none
        v.backgroundColor = .listBackground
        v.headerView = nil
        
        v.autoresizingMask = [.width, .height]
        v.floatsGroupRows = true
        v.gridStyleMask = .solidHorizontalGridLineMask
        v.gridColor = .darkGridColor
        v.allowsMultipleSelection = false
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "session"))
        v.addTableColumn(column)
        
        return v
    }()
    
    lazy var scrollView: NSScrollView = {
        let v = NSScrollView()
        
        v.focusRingType = .none
        //        v.backgroundColor = .listBackground
        v.wantsLayer = true
        v.backgroundColor = .red
        v.borderType = .noBorder
        v.documentView = self.tableView
        v.hasVerticalScroller = true
        v.hasHorizontalScroller = false
        v.translatesAutoresizingMaskIntoConstraints = false
        //        v.alphaValue = 0
        return v
    }()
    
    
    // MARK:
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: MainWindowController.defaultRect.height))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkWindowBackground.cgColor
        view.widthAnchor.constraint(lessThanOrEqualToConstant: 675).isActive = true
        
        scrollView.frame = view.bounds
        tableView.frame = view.bounds
        
//        scrollView.widthAnchor
//            .constraint(greaterThanOrEqualToConstant: 320)
//            .isActive = true
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.width.equalToSuperview()
        }
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
