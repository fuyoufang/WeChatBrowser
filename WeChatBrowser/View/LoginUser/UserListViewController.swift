//
//  UserListViewController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import RxSwift
import RxRelay
import RxCocoa

class UserListViewController: TableViewController {
    
    // MARK: Properties
    private let disposeBag = DisposeBag()
    private let manager: TIMManager
    private var userManagers: [TIMUserManager]?
    var selectedUserManager = BehaviorRelay<TIMUserManager?>(value: nil)

    
    // MARK: Initialize
    init(imManager: TIMManager) {
        self.manager = imManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManagers = manager.userManagerList
        setupSubviews()
        
        tableView.rx.selectedRow.map { index -> TIMUserManager? in
            guard let index = index else { return nil }
            guard let user = self.userManagers?[index] else {
                return nil
            }
            return user
        }.bind(to: selectedUserManager).disposed(by: disposeBag)
        
        if let cell = tableView.accessibilityVisibleCells()?.first as? NSCell {
            tableView.selectCell(cell)
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.makeFirstResponder(tableView)
    }
    
    func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Metrics.sessionRowHeight
    }
    
}

extension UserListViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    fileprivate struct Metrics {
        static let sessionRowHeight: CGFloat = 64
    }
    
    private struct Constants {
        static let rowIdentifier = "row"
        static let sessionCellIdentifier = "sessionCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return userManagers?.count ?? 0
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let user = userManagers?[row].user {
            return cellForSession(user)
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier), owner: tableView) as? TableRowView
        
        if rowView == nil {
            rowView = TableRowView(frame: .zero)
            rowView?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier)
        }
        
        return rowView
    }
    
    private func cellForSession(_ user: IMUser) -> UserListTableCellView? {
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier), owner: tableView) as? UserListTableCellView
        
        if cell == nil {
            cell = UserListTableCellView(frame: .zero)
            cell?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier)
        }
        cell?.user = user
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return Metrics.sessionRowHeight
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: NSTableView, isGroupRow row: Int) -> Bool {
        return false
    }
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        
    }
}
