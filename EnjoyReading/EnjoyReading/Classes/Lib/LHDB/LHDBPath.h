//
//  LHDBPath.h
//  LHDBDemo
//
//  Created by 3wchina01 on 16/2/26.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHDBPath : NSObject

@property (nonatomic,strong) NSString* dbPath;

+ (instancetype)instanceManagerWith:(NSString*)dbPath;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com