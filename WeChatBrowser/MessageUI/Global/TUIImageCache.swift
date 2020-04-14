//
//  TUIImageCache.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/14.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class TUIImageCache {
    static let shared = TUIImageCache()
    private var resourceCache = [String : NSImage]()
//    var faceCache: []
    
    private init() {
        
    }
    
    func addResourceToCache(path: String) {
//        __weak typeof(self) ws = self;
//        [THelper asyncDecodeImage:path complete:^(NSString *key, UIImage *image) {
//            __strong __typeof(ws) strongSelf = ws;
//            [strongSelf.resourceCache setValue:image forKey:key];
//        }];
    }
    func getResourceFromCache(path: String) -> NSImage? {
        // TODO: 暂时无法将图片进行拉伸，所有直接返回 nil
        return nil
//        if path.count == 0 {
//            return nil
//        }
//        var image = resourceCache[path]
//        if image == nil {
//            image = NSImage(named: path)
//        }
//        return image
    }

//    - (void)addFaceToCache:(NSString *)path
//    {
//        __weak typeof(self) ws = self;
//        [THelper asyncDecodeImage:path complete:^(NSString *key, UIImage *image) {
//            __strong __typeof(ws) strongSelf = ws;
//            [strongSelf.faceCache setValue:image forKey:key];
//        }];
//    }
//
//    - (UIImage *)getFaceFromCache:(NSString *)path
//    {
//        if(path.length == 0){
//            return nil;
//        }
//        UIImage *image = [_faceCache objectForKey:path];
//        if(!image){
//            image = [UIImage imageNamed:path];
//        }
//        return image;
//    }
}
