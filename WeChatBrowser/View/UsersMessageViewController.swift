//
//  UsersMessageViewController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import RxSwift

final class UsersMessageViewController: NSSplitViewController {
    private let disposeBag = DisposeBag()
    var userListViewController: UserListViewController
    var conversationListController: ConversationListController
    var conversationMessageController: ConversationMessageController
    var isResizingSplitView = false
    var windowController: MainWindowController
    var setupDone = false

    init(windowController: MainWindowController, imManager: TIMManager) {
        self.windowController = windowController
        userListViewController = UserListViewController(imManager: imManager)
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

        let userListItem = NSSplitViewItem(sidebarWithViewController: userListViewController)
        userListItem.canCollapse = false
        userListItem.minimumThickness = 100
        userListItem.maximumThickness = 100
        
        let conversationListItem = NSSplitViewItem(sidebarWithViewController: conversationListController)
        conversationListItem.canCollapse = false
        conversationListItem.minimumThickness = 200
        conversationListItem.maximumThickness = 200
        
        let conversationMessageItem = NSSplitViewItem(viewController: conversationMessageController)

        addSplitViewItem(userListItem)
        addSplitViewItem(conversationListItem)
        addSplitViewItem(conversationMessageItem)

        userListViewController.view
            .setContentHuggingPriority(.defaultHigh, for: .horizontal)
        userListViewController.view
            .setContentHuggingPriority(.defaultLow, for: .horizontal)
        userListViewController.view
            .setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        conversationListController.view
            .setContentHuggingPriority(.defaultHigh, for: .horizontal)
        conversationMessageController.view
            .setContentHuggingPriority(.defaultLow, for: .horizontal)
        conversationMessageController.view
            .setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        setupBind()
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

    var selectedUserManager: Observable<TIMUserManager?> {
        return userListViewController.selectedUserManager.asObservable()
    }

    var selectedUserManagerValue: TIMUserManager? {
        return userListViewController.selectedUserManager.value
    }
    
    func setupBind() {
        bind(user: selectedUserManager, to: conversationListController)
    }
    
    func bind(user: Observable<TIMUserManager?>, to conversationList: ConversationListController) {

        user.subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { userManager in
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.35

                conversationList.userManager = userManager
            })

        }).disposed(by: disposeBag)
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
