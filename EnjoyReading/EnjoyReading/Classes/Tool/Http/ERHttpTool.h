//
//  ERHttpTool.h
//  毛毛微博
//
//  Created by 王亮 on 16/1/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//  专门处理网络请求

#import <Foundation/Foundation.h>


@interface ERHttpTool : NSObject

/**  发送GET请求 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**  发送POST请求 */
+ (void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

////带headerfield
//+ (void)GET:(NSString *)URLString
//headerField:(NSString *)headerField
// parameters:(id)parameters
//    success:(void (^)(id responseObject))success
//    failure:(void (^)(NSError *error))failure;
//
////带headerfield
//+ (void)POST:(NSString *)URLString
//headerField:(NSString *)headerField
// parameters:(id)parameters
//    success:(void (^)(id responseObject))success
//    failure:(void (^)(NSError *error))failure;

@end


