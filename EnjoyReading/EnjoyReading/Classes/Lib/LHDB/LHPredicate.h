//
//  LHPredicate.h
//  LHDBDemo
//
//  Created by 3wchina01 on 16/2/14.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHPredicate : NSObject

@property (nonatomic,strong) NSMutableArray* propertyNameArray;

@property (nonatomic,strong) NSString* predicateFormat;

@property (nonatomic,strong) NSString* sortString;


- (instancetype)initWithString:(NSString*)string;

- (instancetype)initWithString:(NSString *)string OrderBy:(NSString*)sortString;

+ (instancetype)predicateWithString:(NSString *)string;

+ (instancetype)predicateWithString:(NSString *)string OrderBy:(NSString *)sortString;


- (instancetype)initWithFormat:(NSString*)name, ...NS_FORMAT_FUNCTION(1,2);

- (instancetype)initWithOrderBy:(NSString*)sortString Format:(NSString *)name, ...NS_FORMAT_FUNCTION(1,3);


+ (instancetype)predicateWithFormat:(NSString*)name, ...NS_FORMAT_FUNCTION(1,2);

- (instancetype)initWithPropertyName:(NSString*)name, ...NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)predicateWithPropertyName:(NSString*)name, ...NS_REQUIRES_NIL_TERMINATION;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com