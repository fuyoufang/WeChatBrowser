//
//  ConversationMessageController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

/**
 *  TUIKit 聊天消息控制器
 *  负责消息气泡的展示，同时负责响应用户对于消息气泡的交互，比如：点击消息发送者头像、轻点消息、长按消息等操作。
 *  聊天消息控制器的详细信息请参考 Section\Chat\TUIMessageController.h
 */

// TUIMessageController

class ConversationMessageController: TableViewController {
    
    // MARK: Properies
    var uiMsgs = [TUIMessageCellData]()
    var heightCache = [CGFloat]()
    var msgForDate: TIMMessage?
    var msgForGet: TIMMessage?
    var menuUIMsg: TUIMessageCellData?
    var reSendUIMsg: TUIMessageCellData?
       
    var isScrollBottom: Bool = false
    var isLoadingMsg: Bool = false
    var isInVC: Bool = false
    var isActive: Bool = false
    var noMoreMsg: Bool = false
    var firstLoad: Bool = false
    var conversationDataProviderService: TUIConversationDataProviderServiceProtocol
    var friendshipManager: TIMFriendshipManager? {
        return conversation?.friendshipManager
    }
    
    var conversation: TIMConversation? {
        didSet {
            refreshMessage()
        }
    }
    
    override func viewWillAppear() {
        isInVC = true
        super.viewWillAppear()
    }

    override func viewWillDisappear() {
        isInVC = false
        super.viewWillDisappear()
    }

    func applicationBecomeActive() {
        isActive = true
        
    }

    func applicationEnterBackground() {
        self.isActive = false
    }

    func setupViews() {
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewController)];
//        [self.view addGestureRecognizer:tap];
//        self.tableView.estimatedRowHeight = 0;
//        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        self.tableView.backgroundColor = TMessageController_Background_Color;
//
//        [self.tableView registerClass:[TUITextMessageCell class] forCellReuseIdentifier:TTextMessageCell_ReuseId];
//        [self.tableView registerClass:[TUIVoiceMessageCell class] forCellReuseIdentifier:TVoiceMessageCell_ReuseId];
//        [self.tableView registerClass:[TUIImageMessageCell class] forCellReuseIdentifier:TImageMessageCell_ReuseId];
//        [self.tableView registerClass:[TUISystemMessageCell class] forCellReuseIdentifier:TSystemMessageCell_ReuseId];
//        [self.tableView registerClass:[TUIFaceMessageCell class] forCellReuseIdentifier:TFaceMessageCell_ReuseId];
//        [self.tableView registerClass:[TUIVideoMessageCell class] forCellReuseIdentifier:TVideoMessageCell_ReuseId];
//        [self.tableView registerClass:[TUIFileMessageCell class] forCellReuseIdentifier:TFileMessageCell_ReuseId];
//        [self.tableView registerClass:[TUIJoinGroupMessageCell class] forCellReuseIdentifier:TJoinGroupMessageCell_ReuseId];
//
//
//        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, TMessageController_Header_Height)];
//        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        self.tableView.tableHeaderView = _indicatorView;

        
        firstLoad = true
    }

    func loadMessage() {
        if isLoadingMsg || noMoreMsg {
            return
        }
        
        guard let conversation = conversation else {
            return
        }
        
        isLoadingMsg = true
        let msgCount = 20

        _ = conversationDataProviderService
            .getMessage(conv: conversation, count: msgCount, last: msgForGet, succ: { [weak self] (msgs) in
                guard let self = self else { return }
                
                if msgs.count > 0 {
                    self.msgForGet = msgs.last
                }
                let uiMsgs = self.transUIMsg(fromIMMsg: msgs)
                DispatchQueue.main.async {
                    if msgs.count < msgCount {
                        self.noMoreMsg = true
                    }
                    if uiMsgs.count != 0 {
                        self.uiMsgs.insert(contentsOf: uiMsgs, at: 0)
                        self.heightCache.removeAll()
                        self.tableView.reloadData()
                        // [self.tableView layoutIfNeeded];
                        self.tableView.layoutSubtreeIfNeeded()
                        
                        if !self.firstLoad {
                            var visibleHeight: CGFloat = 0
                            for i in 0..<self.uiMsgs.count {
                                visibleHeight += self.tableView(self.tableView, heightOfRow: i)
                            }
//                            if self.noMoreMsg {
//                                visibleHeight -= TMessageController_Header_Height
//                            }
                        //                        [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentOffset.y + visibleHeight, self.tableView.frame.size.width, self.tableView.frame.size.height) animated:NO];
                        }
                    }
                    self.isLoadingMsg = false
                    self.firstLoad = false
                }
        }) { [weak self] (code, msg) in
            debugPrint("获取记录失败：\(code), \(msgCount)")
            guard let self = self else { return }
            self.isLoadingMsg = false
        }

    }

    func transUIMsg(fromIMMsg msgs: [TIMMessage]) -> [TUIMessageCellData] {
        
        var uiMsgs = [TUIMessageCellData]()
        for msg in msgs.reversed() {
            if msg.status == .HAS_DELETED {
                continue
            }
            var hasShowElem = false
            for elem in msg.elems {
                if elem is TIMSNSSystemElem || elem is TIMProfileSystemElem {
                    continue
                } else if let gt = elem as? TIMGroupTipsElem {
                    if gt.group != conversation?.receiver {
                        continue
                    }
                } else if let gs = elem as? TIMGroupSystemElem {
                    if gs.group != conversation?.receiver {
                        continue
                    }
                } else if msg.conversation.receiver != conversation?.receiver {
                    continue
                }
                hasShowElem = true
            }
            if !hasShowElem {
                continue
            }
            let dateMsg = transSystemMsg(fromDate: msg.timestamp)
            if dateMsg != nil {
                msgForDate = msg
                uiMsgs.append(dateMsg!)
            }
            
            if msg.status == .LOCAL_REVOKED {
                let revoke = msg.revokeCellData()
                if revoke != nil {
                    uiMsgs.append(revoke)
                }
                continue
            }
            
            for elem in msg.elems {
                if elem is TIMSNSSystemElem || elem is TIMProfileSystemElem {
                    continue
                }
                guard let data: TUIMessageCellData = msg.cellData(friendshipManager: friendshipManager, fromElem: elem) else {
                    continue
                }
                
//                if([[msg getConversation] getType] == TIM_GROUP && !msg.isSelf
//                   && ![data isKindOfClass:[TUISystemMessageCellData class]]){
//                    data.showName = YES;
//                }
                
//                    data.direction = msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming;
//                    data.identifier = [msg sender];
//                    //由于拉取名称的过程，可能收到异步/网络等因素的影响，所以在此处现将 userID 设为 userName，防止出现昵称为空的情况。
//                    data.name = data.identifier;
//
//                    void (^block)(TIMUserProfile *) = ^(TIMUserProfile *profile)  {
//                        if([[msg getConversation] getType] == TIM_GROUP){
//                            //如果是群组消息，优先拉取群名片
//                            data.name = [msg getSenderGroupMemberProfile].nameCard;
//                        }
//                        //更新 profile
//                        NSString *showName = [profile showName];
//                        if (showName.length > 0)
//                            data.name = showName;
//                        if (profile.faceURL)
//                            data.avatarUrl = [NSURL URLWithString:[profile faceURL]];
//                    };
//
//                    [msg getSenderProfile:block];
//                    //此处改为 群名片>昵称>ID。当高优先级为空时在使用低优先级变量。
//                    //TIMUserProfile *userProfile = [[TIMFriendshipManager sharedInstance] queryUserProfile:msg.sender];
//                    //data.name = nameCard.length ? nameCard : userProfile.showName;
//                    switch (msg.status) {
//                        case TIM_MSG_STATUS_SEND_SUCC:
//                            data.status = Msg_Status_Succ;
//                            break;
//                        case TIM_MSG_STATUS_SEND_FAIL:
//                            data.status = Msg_Status_Fail;
//                            break;
//                        case TIM_MSG_STATUS_SENDING:
//                            data.status = Msg_Status_Sending_2;
//                            break;
//                        default:
//                            break;
//                    }
                uiMsgs.append(data)
                data.innerMessage = msg
                    
//                }
            }
        }
        return uiMsgs
    }
    
    /**
    *  滚动至底部
    *  通过对 tableView 进行设置，使当前视图滚动至底部。
    *  建议在需要返回至消息视图底部或者需要浏览最新信息时调用，比如每次发送消息、接收消息、撤回消息、删除消息时。
    *  本函数的实现调用了 tableView 的滑动函数：
    * <pre>
    *  [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:uiMsgs.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
    * </pre>
    *  其中第一个参数出现的 uiMsgs，即当前消息控制器中已接收到并展示的消息数组。
    *
    *  @param animate 动画标志位。YES：启用动画；NO：禁用动画。
    */
    func scrollToBottom(animate: Bool) {
        fatalError()
//        if (_uiMsgs.count > 0) {
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_uiMsgs.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
//        }
    }

    func didTapViewController() {
        fatalError()
//        if(_delegate && [_delegate respondsToSelector:@selector(didTapInMessageController:)]){
//            [_delegate didTapInMessageController:self];
//        }
    }

//    - (void)changeMsg:(TUIMessageCellData *)msg status:(TMsgStatus)status
//    {
//        msg.status = status;
//        NSInteger index = [_uiMsgs indexOfObject:msg];
//        TUIMessageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        [cell fillWithData:msg];
//    }

    func transIMMsgFromUIMsg(data: TUIMessageCellData) -> TIMMessage {
        fatalError()
//        TIMMessage *msg = [[TIMMessage alloc] init];
//        if([data isKindOfClass:[TUITextMessageCellData class]]){
//            TIMTextElem *imText = [[TIMTextElem alloc] init];
//            TUITextMessageCellData *text = (TUITextMessageCellData *)data;
//            imText.text = text.content;
//            [msg addElem:imText];
//        }
//        else if([data isKindOfClass:[TUIFaceMessageCellData class]]){
//            TIMFaceElem *imImage = [[TIMFaceElem alloc] init];
//            TUIFaceMessageCellData *image = (TUIFaceMessageCellData *)data;
//            imImage.index = (int)image.groupIndex;
//            imImage.data = [image.faceName dataUsingEncoding:NSUTF8StringEncoding];
//            [msg addElem:imImage];
//        }
//        else if([data isKindOfClass:[TUIImageMessageCellData class]]){
//            TIMImageElem *imImage = [[TIMImageElem alloc] init];
//            TUIImageMessageCellData *uiImage = (TUIImageMessageCellData *)data;
//            imImage.path = uiImage.path;
//            [msg addElem:imImage];
//        }
//        else if([data isKindOfClass:[TUIVideoMessageCellData class]]){
//            TIMVideoElem *imVideo = [[TIMVideoElem alloc] init];
//            TUIVideoMessageCellData *uiVideo = (TUIVideoMessageCellData *)data;
//            imVideo.videoPath = uiVideo.videoPath;
//            imVideo.snapshotPath = uiVideo.snapshotPath;
//            imVideo.snapshot = [[TIMSnapshot alloc] init];
//            imVideo.snapshot.width = uiVideo.snapshotItem.size.width;
//            imVideo.snapshot.height = uiVideo.snapshotItem.size.height;
//            imVideo.video = [[TIMVideo alloc] init];
//            imVideo.video.duration = (int)uiVideo.videoItem.duration;
//            imVideo.video.type = uiVideo.videoItem.type;
//            [msg addElem:imVideo];
//        }
//        else if([data isKindOfClass:[TUIVoiceMessageCellData class]]){
//            TIMSoundElem *imSound = [[TIMSoundElem alloc] init];
//            TUIVoiceMessageCellData *uiSound = (TUIVoiceMessageCellData *)data;
//            imSound.path = uiSound.path;
//            imSound.second = uiSound.duration;
//            imSound.dataSize = uiSound.length;
//            [msg addElem:imSound];
//        }
//        else if([data isKindOfClass:[TUIFileMessageCellData class]]){
//            TIMFileElem *imFile = [[TIMFileElem alloc] init];
//            TUIFileMessageCellData *uiFile = (TUIFileMessageCellData *)data;
//            imFile.path = uiFile.path;
//            imFile.fileSize = uiFile.length;
//            imFile.filename = uiFile.fileName;
//            [msg addElem:imFile];
//        }
//        data.innerMessage = msg;
//        return msg;

    }
    let MAX_MESSAGE_SEP_DLAY: TimeInterval = (5 * 60)
    
    func transSystemMsg(fromDate date: Date) -> TUISystemMessageCellData? {
        guard let msgForDate = self.msgForDate, date.timeIntervalSince(msgForDate.timestamp) < MAX_MESSAGE_SEP_DLAY else {
            let system: TUISystemMessageCellData = TUISystemMessageCellData(direction: .outgoing)
            system.content = date.tk_messageString()
            system.reuseId = Constants.TSystemMessageCell_ReuseId
            return system
        }
        return nil
    }

//    - (void)scrollViewDidScroll:(UIScrollView *)scrollView
//    {
//        if(!_noMoreMsg && scrollView.contentOffset.y <= TMessageController_Header_Height){
//            if(!_indicatorView.isAnimating){
//                [_indicatorView startAnimating];
//            }
//        }
//        else{
//            if(_indicatorView.isAnimating){
//                [_indicatorView stopAnimating];
//            }
//        }
//    }

//    - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//    {
//        if(scrollView.contentOffset.y <= TMessageController_Header_Height){
//            [self loadMessage];
//        }
//    }

    func onSelectMessage(cell: UIMessageCell) {
        fatalError()
//
//        if([cell isKindOfClass:[TUIVoiceMessageCell class]]){
//            [self playVoiceMessage:(TUIVoiceMessageCell *)cell];
//        }
//        if ([cell isKindOfClass:[TUIImageMessageCell class]]) {
//            [self showImageMessage:(TUIImageMessageCell *)cell];
//        }
//        if ([cell isKindOfClass:[TUIVideoMessageCell class]]) {
//            [self showVideoMessage:(TUIVideoMessageCell *)cell];
//        }
//        if ([cell isKindOfClass:[TUIFileMessageCell class]]) {
//            [self showFileMessage:(TUIFileMessageCell *)cell];
//        }
//        if ([self.delegate respondsToSelector:@selector(messageController:onSelectMessageContent:)]) {
//            [self.delegate messageController:self onSelectMessageContent:cell];
//        }
    }

    func onLongPressMessage(cell: UIMessageCell) {
        fatalError()
//        TUIMessageCellData *data = cell.messageData;
//        if ([data isKindOfClass:[TUISystemMessageCellData class]])
//            return; // 系统消息不响应
//
//        NSMutableArray *items = [NSMutableArray array];
//        if ([data isKindOfClass:[TUITextMessageCellData class]]) {
//            [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(onCopyMsg:)]];
//        }
//
//        [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(onDelete:)]];
//        TIMMessage *imMsg = data.innerMessage;
//        if(imMsg){
//            if([imMsg isSelf] && [[NSDate date] timeIntervalSinceDate:imMsg.timestamp] < 2 * 60){
//                [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回" action:@selector(onRevoke:)]];
//            }
//        }
//        if(imMsg.status == TIM_MSG_STATUS_SEND_FAIL){
//            [items addObject:[[UIMenuItem alloc] initWithTitle:@"重发" action:@selector(onReSend:)]];
//        }
//
//
//        BOOL isFirstResponder = NO;
//        if(_delegate && [_delegate respondsToSelector:@selector(messageController:willShowMenuInCell:)]){
//            isFirstResponder = [_delegate messageController:self willShowMenuInCell:cell];
//        }
//        if(isFirstResponder){
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
//        }
//        else{
//            [self becomeFirstResponder];
//        }
//        UIMenuController *controller = [UIMenuController sharedMenuController];
//        controller.menuItems = items;
//        _menuUIMsg = data;
//        [controller setTargetRect:cell.container.bounds inView:cell.container];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [controller setMenuVisible:YES animated:YES];
//        });
    }

    func onSelectMessageAvatar(cell: UIMessageCell) {
//        if ([self.delegate respondsToSelector:@selector(messageController:onSelectMessageAvatar:)]) {
//            [self.delegate messageController:self onSelectMessageAvatar:cell];
//        }
    }

//    -(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//    {
//        if (action == @selector(onDelete:) ||
//            action == @selector(onRevoke:) ||
//            action == @selector(onReSend:) ||
//            action == @selector(onCopyMsg:)){
//            return YES;
//        }
//        return NO;
//    }

//    - (BOOL)canBecomeFirstResponder
//    {
//        return YES;
//    }

//    - (void)onDelete:(id)sender
//    {
//        TIMMessage *imMsg = _menuUIMsg.innerMessage;
//        if(imMsg == nil){
//            return;
//        }
//        if([imMsg remove]){
//            [self.tableView beginUpdates];
//            NSInteger index = [_uiMsgs indexOfObject:_menuUIMsg];
//            [_uiMsgs removeObjectAtIndex:index];
//            [_heightCache removeObjectAtIndex:index];
//            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//
//            [self.tableView endUpdates];
//        }
//    }
//
//    - (void)menuDidHide:(NSNotification*)notification
//    {
//        if(_delegate && [_delegate respondsToSelector:@selector(didHideMenuInMessageController:)]){
//            [_delegate didHideMenuInMessageController:self];
//        }
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerDidHideMenuNotification object:nil];
//    }
//
//    - (void)onCopyMsg:(id)sender
//    {
//        if ([_menuUIMsg isKindOfClass:[TUITextMessageCellData class]]) {
//            TUITextMessageCellData *txtMsg = (TUITextMessageCellData *)_menuUIMsg;
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            pasteboard.string = txtMsg.content;
//        }
//    }
//
//    - (void)onRevoke:(id)sender
//    {
//        __weak typeof(self) ws = self;
//        [self.conv revokeMessage:_menuUIMsg.innerMessage succ:^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [ws revokeMsg:ws.menuUIMsg];
//            });
//        } fail:^(int code, NSString *msg) {
//            NSLog(@"");
//        }];
//    }
//
//    - (void)revokeMsg:(TUIMessageCellData *)msg
//    {
//        TIMMessage *imMsg = msg.innerMessage;
//        if(imMsg == nil){
//            return;
//        }
//        NSInteger index = [_uiMsgs indexOfObject:msg];
//        if (index == NSNotFound)
//            return;
//        [_uiMsgs removeObject:msg];
//
//        [self.tableView beginUpdates];
//        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//        TUISystemMessageCellData *data = [imMsg revokeCellData];
//        [_uiMsgs insertObject:data atIndex:index];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//        [self.tableView endUpdates];
//        [self scrollToBottom:YES];
//    }
//
//    - (void)playVoiceMessage:(TUIVoiceMessageCell *)cell
//    {
//        for (NSInteger index = 0; index < _uiMsgs.count; ++index) {
//            if(![_uiMsgs[index] isKindOfClass:[TUIVoiceMessageCellData class]]){
//                continue;
//            }
//            TUIVoiceMessageCellData *uiMsg = _uiMsgs[index];
//            if(uiMsg == cell.voiceData){
//                [uiMsg playVoiceMessage];
//                cell.voiceReadPoint.hidden = YES;
//            }
//            else{
//                [uiMsg stopVoiceMessage];
//            }
//        }
//    }
//
//    - (void)showImageMessage:(TUIImageMessageCell *)cell
//    {
//        TUIImageViewController *image = [[TUIImageViewController alloc] init];
//        image.data = [cell imageData];
//        [self.navigationController pushViewController:image animated:YES];
//    }
//
//    - (void)showVideoMessage:(TUIVideoMessageCell *)cell
//    {
//        TUIVideoViewController *video = [[TUIVideoViewController alloc] init];
//        video.data = [cell videoData];
//        [self.navigationController pushViewController:video animated:YES];
//    }
//
//    - (void)showFileMessage:(TUIFileMessageCell *)cell
//    {
//        TUIFileViewController *file = [[TUIFileViewController alloc] init];
//        file.data = [cell fileData];
//        [self.navigationController pushViewController:file animated:YES];
//    }
//
//
//    - (void)didTapOnRestNameLabel:(TUIJoinGroupMessageCell *)cell withIndex:(NSInteger)index{
//        [self jumpToProfileController:cell.joinData.userID[index]];
//    }
//    - (void)jumpToProfileController:(NSString *)memberId{
//        //此处实现点击入群的姓名 Label 后，跳转到对应的消息界面。此处的跳转逻辑和点击头像的跳转逻辑相同。
//        @weakify(self)
//        TIMFriend *friend = [[TIMFriendshipManager sharedInstance] queryFriend:memberId];
//        if (friend) {
//            id<TUIFriendProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIFriendProfileControllerServiceProtocol)];
//            if ([vc isKindOfClass:[UIViewController class]]) {
//                vc.friendProfile = friend;
//                [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
//                return;
//            }
//        }
//
//        [[TIMFriendshipManager sharedInstance] getUsersProfile:@[memberId] forceUpdate:YES succ:^(NSArray<TIMUserProfile *> *profiles) {
//            @strongify(self)
//            if (profiles.count > 0) {
//                id<TUIUserProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIUserProfileControllerServiceProtocol)];
//                if ([vc isKindOfClass:[UIViewController class]]) {
//                    vc.userProfile = profiles[0];
//                    vc.actionType = PCA_ADD_FRIEND;
//                    [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
//                    return;
//                }
//            }
//        } fail:^(int code, NSString *msg) {
//            [THelper makeToastError:code msg:msg];
//        }];
//    }

//
//    - (void)messageController:(TUIMessageController *)controller onSelectMessageAvatar:(TUIMessageCell *)cell
//    {
//        if (cell.messageData.identifier == nil)
//            return;
//
//        if ([self.delegate respondsToSelector:@selector(chatController:onSelectMessageAvatar:)]) {
//            [self.delegate chatController:self onSelectMessageAvatar:cell];
//            return;
//        }
//
//        @weakify(self)
//        TIMFriend *friend = [[TIMFriendshipManager sharedInstance] queryFriend:cell.messageData.identifier];
//        if (friend) {
//            id<TUIFriendProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIFriendProfileControllerServiceProtocol)];
//            if ([vc isKindOfClass:[UIViewController class]]) {
//                vc.friendProfile = friend;
//                [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
//                return;
//            }
//        }
//
//        [[TIMFriendshipManager sharedInstance] getUsersProfile:@[cell.messageData.identifier] forceUpdate:YES succ:^(NSArray<TIMUserProfile *> *profiles) {
//            @strongify(self)
//            if (profiles.count > 0) {
//                id<TUIUserProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIUserProfileControllerServiceProtocol)];
//                if ([vc isKindOfClass:[UIViewController class]]) {
//                    vc.userProfile = profiles[0];
//                    vc.actionType = PCA_ADD_FRIEND;
//                    [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
//                    return;
//                }
//            }
//        } fail:^(int code, NSString *msg) {
//            [THelper makeToastError:code msg:msg];
//        }];
//    }
//
//    - (void)messageController:(TUIMessageController *)controller onSelectMessageContent:(TUIMessageCell *)cell
//    {
//        if ([self.delegate respondsToSelector:@selector(chatController:onSelectMessageContent:)]) {
//            [self.delegate chatController:self onSelectMessageContent:cell];
//            return;
//        }
//    }

    init() {
        self.conversationDataProviderService = TCServiceManager.shareInstance().conversationDataProviderService

        super.init(nibName: nil, bundle: nil)
        
        identifier = NSUserInterfaceItemIdentifier(rawValue: "ConversationListController")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Metrics.sessionRowHeight
        
        tableView.wantsLayer = true
        let bgColor = NSColor(red: 243.0 / 255.0,
                              green: 243.0 / 255.0,
                              blue: 243.0 / 255.0,
                              alpha: 1).cgColor
        tableView.layer?.backgroundColor = bgColor
        scrollView.layer?.backgroundColor = bgColor
        view.layer?.backgroundColor = bgColor
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func refreshMessage() {
        noMoreMsg = false
        msgForDate = nil
        msgForGet = nil
        menuUIMsg = nil
        reSendUIMsg = nil
           
        isScrollBottom = false
        isLoadingMsg = false
        isInVC = false
        isActive = false
        noMoreMsg = false
        firstLoad = false
        
        uiMsgs.removeAll()
        heightCache.removeAll()
        
        loadMessage()
    }
    
}

// MARK: - Datasource / Delegate

extension ConversationMessageController: NSTableViewDataSource, NSTableViewDelegate {
    
    fileprivate struct Metrics {
        static let headerRowHeight: CGFloat = 20
        static let sessionRowHeight: CGFloat = 64
    }
    
    private struct Constants {
//        static let sessionCellIdentifier = "sessionCell"
        static let rowIdentifier = "row"
        static let TSystemMessageCell_ReuseId = "TSystemMessageCell"
        static let TJoinGroupMessageCell_ReuseId = "TJoinGroupMessageCell"
        static let TImageMessageCell_ReuseId = "TImageMessageCell"
        static let TFaceMessageCell_ReuseId = "TFaceMessageCell"
        static let TVideoMessageCell_ReuseId = "TVideoMessageCell"
        static let TVoiceMessageCell_ReuseId = "TVoiceMessaageCell"
        static let TFileMessageCell_ReuseId = "TFileMessageCell"
        static let TTextMessageCell_ReuseId = "TTextMessageCell"

    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return uiMsgs.count
    }

    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let uiMsg = uiMsgs[row]
        return cellForSessionView(data: uiMsg)
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier), owner: tableView) as? TableRowView
        
        if rowView == nil {
            rowView = TableRowView(frame: .zero)
            rowView?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier)
        }
        
        return rowView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if heightCache.count > row {
            return heightCache[row]
        }
        let data: TUIMessageCellData = uiMsgs[row]
        let maxWidth: CGFloat = 300
        let height: CGFloat = data.height(ofWidth: maxWidth)
        heightCache.insert(height, at: row)
        return height
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
    
    func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
        if isScrollBottom == false {
            scrollToBottom(animate: false)
            if row == uiMsgs.count - 1 {
                isScrollBottom = true
            }
        }
    }
    
    private func cellForSessionView(data: TUIMessageCellData) -> UIMessageCell? {
        if data.reuseId == nil {
            if data is TUITextMessageCellData {
                data.reuseId = Constants.TTextMessageCell_ReuseId
            } else if data is TUIFaceMessageCellData {
                data.reuseId = Constants.TFaceMessageCell_ReuseId
            } else if data is TUIImageMessageCellData {
                data.reuseId = Constants.TImageMessageCell_ReuseId
            } else if data is TUIVideoMessageCellData {
                data.reuseId = Constants.TVideoMessageCell_ReuseId
            } else if data is TUIVoiceMessageCellData {
                data.reuseId = Constants.TVoiceMessageCell_ReuseId
            } else if data is TUIFileMessageCellData {
                data.reuseId = Constants.TFileMessageCell_ReuseId
            } else if data is TUIJoinGroupMessageCellData {
                data.reuseId = Constants.TJoinGroupMessageCell_ReuseId
            } else if data is TUISystemMessageCellData {
                data.reuseId = Constants.TSystemMessageCell_ReuseId
            } else {
                return nil
            }
        }
        
        guard let reuseId = data.reuseId else {
            return nil
        }
        
        
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: reuseId), owner: tableView) as? UIMessageCell
           
        if cell == nil {
            if reuseId == Constants.TTextMessageCell_ReuseId {
                cell = TextMessageCell(frame: .zero)
            } else if reuseId == Constants.TFaceMessageCell_ReuseId {
//                TUIFaceMessageCell
            } else if reuseId == Constants.TImageMessageCell_ReuseId {
//                TUIImageMessageCell
            } else if reuseId == Constants.TVideoMessageCell_ReuseId {
//                TUIVideoMessageCell
            } else if reuseId == Constants.TVoiceMessageCell_ReuseId {
                // TUIVoiceMessageCell
                
            } else if reuseId == Constants.TFileMessageCell_ReuseId {
//                TUIFileMessageCell
            } else if reuseId == Constants.TJoinGroupMessageCell_ReuseId {
//                TUIJoinGroupMessageCell
            } else if reuseId == Constants.TSystemMessageCell_ReuseId {
//                TUISystemMessageCell
            }
             cell?.identifier = NSUserInterfaceItemIdentifier(rawValue: reuseId)
        }
           
        
        
        
        //        cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId forIndexPath:indexPath];
        //        //对于入群小灰条，需要进一步设置其委托。
        //        if([cell isKindOfClass:[TUIJoinGroupMessageCell class]]){
        //            TUIJoinGroupMessageCell *joinCell = (TUIJoinGroupMessageCell *)cell;
        //            joinCell.joinGroupDelegate = self;
        //            cell = joinCell;
        //        }
        //        cell.delegate = self;
        
        cell?.fill(withData: data)
        
           
           return cell
       }
   

    //    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    //    {
    //    }
}
