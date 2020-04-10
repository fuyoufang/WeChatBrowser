//
//  ConversationListController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class SessionViewModel {
    
}

class ConversationListController: TableViewController, NSMenuItemValidation {
    
    // MARK: Properies
    private let imManager: TIMManager
    
    var viewModel: TConversationListViewModel
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
    
    
    init(imManager: TIMManager) {
        self.imManager = imManager
        self.viewModel = {
            let model = TConversationListViewModel(imManager: imManager)
            model.listFilter = { data -> Bool in
                return data.convType != .SYSTEM
            }
            return model
        }()
        super.init(nibName: nil, bundle: nil)
        
        identifier = NSUserInterfaceItemIdentifier(rawValue: "videosList")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Metrics.sessionRowHeight
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.makeFirstResponder(tableView)
    }
    
}

// MARK: - Datasource / Delegate

extension ConversationListController: NSTableViewDataSource, NSTableViewDelegate {
    
    fileprivate struct Metrics {
        static let headerRowHeight: CGFloat = 20
        static let sessionRowHeight: CGFloat = 64
    }
    
    private struct Constants {
        static let sessionCellIdentifier = "sessionCell"
        static let titleCellIdentifier = "titleCell"
        static let rowIdentifier = "row"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.dataList.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let model = SessionViewModel()
        return cellForSessionViewModel(model)
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier), owner: tableView) as? TableRowView
        
        if rowView == nil {
            rowView = TableRowView(frame: .zero)
            rowView?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier)
        }
        
        return rowView
    }
    
    private func cellForSessionViewModel(_ viewModel: SessionViewModel) -> ConversationListView? {
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier), owner: tableView) as? ConversationListView
        
        if cell == nil {
            cell = ConversationListView(frame: .zero)
            cell?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier)
        }
        
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
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        debugPrint(tableView.selectedRow)
        
    }
    
}
