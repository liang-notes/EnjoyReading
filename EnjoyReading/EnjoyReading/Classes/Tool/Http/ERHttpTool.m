//
//  ERHttpTool.m
//  毛毛微博
//
//  Created by 王亮 on 16/1/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHttpTool.h"
#import "AFNetworking.h"


@implementation ERHttpTool
+(void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    [mgr GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 先把请求成功要做的事情保留到这个代码块
        if (success) {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 先把请求失败要做的事情保留到这个代码块
        if (failure) {
            failure(error);
        }

    }];
    
}

+(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 先把请求成功要做的事情保留到这个代码块
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 先把请求失败要做的事情保留到这个代码块
        if (failure) {
            failure(error);
        }
    }];
    
}

//+ (void)GET:(NSString *)URLString headerField:(NSString *)headerField parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    //创建请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
////    mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    [mgr.requestSerializer setValue:headerField forHTTPHeaderField:@"apikey"];
//    //发送请求
//    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//+ (void)POST:(NSString *)URLString headerField:(NSString *)headerField parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    //创建请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    //    mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    [mgr.requestSerializer setValue:headerField forHTTPHeaderField:@"apikey"];
//    //发送请求
//    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

@end
