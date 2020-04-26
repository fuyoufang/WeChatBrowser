//
//  ConversationListController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import RxCocoa
import RxSwift

class ConversationListController: TableViewController {
    
    // MARK: Properies
    private let disposeBag = DisposeBag()
    var userManager: TIMUserManager? {
        didSet {
            refreshViewModel()
        }
    }
    var selectedConversation = BehaviorRelay<TIMConversation?>(value: nil)

    var viewModel: TConversationListViewModel?

    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        identifier = NSUserInterfaceItemIdentifier(rawValue: "ConversationListController")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Metrics.sessionRowHeight
        
        tableView.rx.selectedRow.map { [weak self] index -> TIMConversation? in
            guard let self = self else { return nil }
            guard let index = index else { return nil }
            guard let data = self.viewModel?.dataList[index] else {
                return nil
            }
            guard let convId = data.convId else {
                return nil
            }
            let conversation = self.userManager?.getConversation(type: data.convType, conversationId: convId)
            return conversation
        }.bind(to: selectedConversation).disposed(by: disposeBag)
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
//        view.window?.makeFirstResponder(tableView)
    }
    
    func refreshViewModel() {
        defer {
            tableView.reloadData()
            if (self.viewModel?.dataList.count ?? 0) > 0 {
                let indexes = IndexSet(integer: 0)
                tableView.selectRowIndexes(indexes, byExtendingSelection: false)
            }
        }
        guard let userManager = userManager else {
            self.viewModel = nil
            return
        }
        
        self.viewModel = {
            let model = TConversationListViewModel(manager: userManager)
            model.listFilter = { data -> Bool in
                return data.convType != .SYSTEM
            }
            return model
        }()
        
        
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
        static let rowIdentifier = "row"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel?.dataList.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellData = viewModel?.dataList[row]
        return cellForSessionView(cellData: cellData)
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier), owner: tableView) as? TableRowView
        
        if rowView == nil {
            rowView = TableRowView(frame: .zero)
            rowView?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier)
        }
        
        return rowView
    }
    
    private func cellForSessionView(cellData: TUIConversationCellData?) -> ConversationListView? {
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier), owner: tableView) as? ConversationListView
        
        if cell == nil {
            cell = ConversationListView(frame: .zero)
            cell?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier)
        }
        cell?.cellData = cellData
        
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
