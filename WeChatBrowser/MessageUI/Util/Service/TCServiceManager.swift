//
//  TCServiceManager.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class TCServiceItem {
    var priority: Int = 0
    var className: String?
    

    func compare(_ obj: TCServiceItem) -> ComparisonResult {
        if self.priority < obj.priority {
            return .orderedDescending
        } else if self.priority > obj.priority {
            return .orderedAscending
        }
        return .orderedSame
        
    }
}

class TCServiceManager {

    var enableException: Bool = false

    private static let manager = TCServiceManager()
    
    private init() {
        
    }
    static func shareInstance() -> TCServiceManager {
        return manager
    }

    var allServicesDict = [String : [TCServiceItem]]()

    
    let lock = NSRecursiveLock()
    
    let messageDataProviderService = TUIMessageDataProviderService.service
    
    let userProfileDataProviderService = TUIUserProfileDataProviderService.service
    
    let conversationDataProviderService = TUIConversationDataProviderService()
//
//    - (void)registerService:(Protocol *)service implClass:(Class)implClass
//    {
//        [self registerService:service implClass:implClass withPriority:INT_MAX];
//    }
//
//    - (void)registerService:(Protocol *)service implClass:(Class)implClass withPriority:(int)priority
//    {
//        NSParameterAssert(service != nil);
//        NSParameterAssert(implClass != nil);
//
//        if (![implClass conformsToProtocol:service]) {
//            if (self.enableException) {
//                @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ module does not comply with %@ protocol", NSStringFromClass(implClass), NSStringFromProtocol(service)] userInfo:nil];
//            }
//            return;
//        }
//
//
//        NSString *key = NSStringFromProtocol(service);
//        NSString *value = NSStringFromClass(implClass);
//
//        if (key.length > 0 && value.length > 0) {
//            TCServiceItem *item = TCServiceItem.new;
//            item.priority = priority;
//            item.className = value;
//
//            [self.lock lock];
//            NSMutableArray *items = [self.allServicesDict objectForKey:key];
//            if (!items) {
//                self.allServicesDict[key] = [NSMutableArray arrayWithObject:item];
//            } else {
//                [items insertObject:item atIndex:0];
//                [items sortUsingSelector:@selector(compare:)];
//                // set higher priority class to be used instance
//                if (items.firstObject == item) {
//                    [self removeServiceInstance:service];
//                }
//            }
//            [self.lock unlock];
//        }
//    }
//
//    - (void)unregisterService:(Protocol *)service implClass:(Class)implClass;
//    {
//        NSParameterAssert(service != nil);
//        NSParameterAssert(implClass != nil);
//
//        NSString *key = NSStringFromProtocol(service);
//        NSString *value = NSStringFromClass(implClass);
//
//        if (key.length > 0 && value.length > 0) {
//            [self.lock lock];
//            NSMutableArray<TCServiceItem *> *items = [self.allServicesDict objectForKey:key];
//            if (items && items.count > 0) {
//                if ([items.firstObject.className isEqualToString:value]) {
//                    [self removeServiceInstance:service];
//                }
//                NSMutableIndexSet *idx = [NSMutableIndexSet new];
//                for (int i = 0; i < items.count; i++) {
//                    if ([items[i].className isEqualToString:value])
//                    {
//                        [idx addIndex:i];
//                    }
//                }
//                [items removeObjectsAtIndexes:idx];
//            }
//            [self.lock unlock];
//        }
//    }

    func createService(service: Protocol) -> Any {
        return createService(service: service, withServiceName: nil)
    }
    
    func createService(service: Protocol, withServiceName serviceName: String?) -> Any {
        return createService(service: service, withServiceName: nil, shouldCache: true)
    }
    
    func createService(service: Protocol, withServiceName serviceName: String?, shouldCache: Bool) -> Any {
    
        fatalError()
//        if (!serviceName?.count) {
//            serviceName = NSStringFromProtocol(service);
//        }
//        id implInstance = nil;
//
//        if (![self checkValidService:service]) {
//            if (self.enableException) {
//                @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ protocol does not been registed", NSStringFromProtocol(service)] userInfo:nil];
//            }
//
//        }
//
//        NSString *serviceStr = serviceName;
//        if (shouldCache) {
//            id protocolImpl = [[TCContext shareInstance] getServiceInstanceFromServiceName:serviceStr];
//            if (protocolImpl) {
//                return protocolImpl;
//            }
//        }
//
//        Class implClass = [self serviceImplClass:service];
//        if ([[implClass class] respondsToSelector:@selector(singleton)]) {
//            if ([[implClass class] singleton]) {
//                if ([[implClass class] respondsToSelector:@selector(shareInstance)])
//                    implInstance = [[implClass class] shareInstance];
//                else
//                    implInstance = [[implClass alloc] init];
//                if (shouldCache) {
//                    [[TCContext shareInstance] addServiceWithImplInstance:implInstance serviceName:serviceStr];
//                    return implInstance;
//                } else {
//                    return implInstance;
//                }
//            }
//        }
//        return [[implClass alloc] init];
    }
    

//    - (id)getServiceInstance:(Protocol *)service
//    {
//        NSString *key = NSStringFromProtocol(service);
//        return [[TCContext shareInstance] getServiceInstanceFromServiceName:key];
//    }
//
//    - (void)removeServiceInstance:(Protocol *)service
//    {
//        NSString *key = NSStringFromProtocol(service);
//        [[TCContext shareInstance] removeServiceInstanceWithServiceName:key];
//    }
//
//
//    #pragma mark - private
//    - (Class)serviceImplClass:(Protocol *)service
//    {
//        NSArray<TCServiceItem *> *serviceImpls = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
//        if (serviceImpls.count > 0) {
//            return NSClassFromString(serviceImpls[0].className);
//        }
//        return nil;
//    }
//
//    - (BOOL)checkValidService:(Protocol *)service
//    {
//        NSArray<TCServiceItem *> *serviceImpls = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
//        if (serviceImpls.count > 0) {
//            return YES;
//        }
//        return NO;
//    }
//
//    - (NSMutableDictionary *)allServicesDict
//    {
//        if (!_allServicesDict) {
//            _allServicesDict = [NSMutableDictionary dictionary];
//        }
//        return _allServicesDict;
//    }
//
//    - (NSRecursiveLock *)lock
//    {
//        if (!_lock) {
//            _lock = [[NSRecursiveLock alloc] init];
//        }
//        return _lock;
//    }
//
//    - (NSDictionary<NSString *, NSArray<TCServiceItem *> *> *)servicesDict
//    {
//        [self.lock lock];
//        NSDictionary *dict = [self.allServicesDict copy];
//        [self.lock unlock];
//        return dict;
//    }
}
