//
//  UsersMessageViewController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

//
final class UsersMessageViewController: NSSplitViewController {

    var conversationListController: ConversationListController
    var conversationMessageController: ConversationMessageController
    var isResizingSplitView = false
    var windowController: MainWindowController
    var setupDone = false

    init(windowController: MainWindowController) {
        self.windowController = windowController
        conversationListController = ConversationListController()
        conversationMessageController = ConversationMessageController()

        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(syncSplitView(notification:)), name: .sideBarSizeSyncNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true

        let listItem = NSSplitViewItem(sidebarWithViewController: conversationListController)
        listItem.canCollapse = false
        let detailItem = NSSplitViewItem(viewController: conversationMessageController)

        addSplitViewItem(listItem)
        addSplitViewItem(detailItem)

        conversationListController.view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        conversationMessageController.view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        conversationMessageController.view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        if !setupDone {
            if let sidebarInitWidth = windowController.sidebarInitWidth {
                splitView.setPosition(sidebarInitWidth, ofDividerAt: 0)
            }
            setupDone = true
        }
    }

    @objc private func syncSplitView(notification: Notification) {
        guard let notificationSourceSplitView = notification.object as? NSSplitView else {
            return
        }
        guard notificationSourceSplitView !== splitView else {
            // If own split view is altered, change split view initialisation width for other tabs
            windowController.sidebarInitWidth = notificationSourceSplitView.subviews[0].bounds.width
            return
        }
        guard splitView.subviews.count > 0, notificationSourceSplitView.subviews.count > 0 else {
            return
        }
        guard splitView.subviews[0].bounds.width != notificationSourceSplitView.subviews[0].bounds.width else {
            return
        }

        // Prevent a split view sync notification from being sent to the other controllers
        // in response to this programmatic resize
        isResizingSplitView = true
        splitView.setPosition(notificationSourceSplitView.subviews[0].bounds.width, ofDividerAt: 0)
        isResizingSplitView = false
    }

    override func splitViewDidResizeSubviews(_ notification: Notification) {
        guard isResizingSplitView == false else { return }
        guard setupDone else { return }

        // This notification should only be posted in response to user input
        NotificationCenter.default.post(name: .sideBarSizeSyncNotification, object: splitView, userInfo: nil)
    }
}

extension Notification.Name {
    public static let sideBarSizeSyncNotification = NSNotification.Name("WWDCSplitViewSizeSyncNotification")
}


//class UsersMessageViewController: NSViewController {
//
//    let userconversationListController = UserconversationListController()
//    let userMessageViewController = UserMessageViewController()
//
//    let conversationTableColumn = NSTableColumn().then {
//        $0.width = 100
//        $0.minWidth = 100
//        $0.maxWidth = 100
//    }
//    let messageTableColumn = NSTableColumn()
//
//    let tableView = NSTableView()
//
//    // MARK: life circle
//
//    override func loadView() {
//        view = NSView()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupSubviews()
//    }
//
//    func setupSubviews() {
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        tableView.addTableColumn(conversationTableColumn)
//        tableView.addTableColumn(messageTableColumn)
//        tableView.delegate = self
//        tableView.dataSource = self
//
//    }
//
//}
//
//extension UsersMessageViewController: NSTableViewDelegate {
//
//    fileprivate enum CellIdentifiers {
//        static let NameCell = "NameCellID"
//        static let DateCell = "DateCellID"
//        static let SizeCell = "SizeCellID"
//    }
//
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//
//        var text: String = ""
//        var cellIdentifier: String = ""
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .long
//
//        // 1
//
//
//        // 2
//        if tableColumn == tableView.tableColumns[0] {
//            //         image = item.icon
//            text = "0"
//            cellIdentifier = CellIdentifiers.NameCell
//        } else if tableColumn == tableView.tableColumns[1] {
//            text = "1"
//            cellIdentifier = CellIdentifiers.DateCell
//        }
//
//        // 3
//        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
//            cell.textField?.stringValue = text
//            return cell
//        }
//        return nil
//    }
//
//    //    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
//    //
//    //    }
//    //
//    //    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//    //
//    //    }
//
//    //    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
//    //        return 80
//    //    }
//}
//
//extension UsersMessageViewController: NSTableViewDataSource {
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return 2
//    }
//}
//
