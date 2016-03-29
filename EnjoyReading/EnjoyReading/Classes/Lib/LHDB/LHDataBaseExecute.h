//
//  LHDataBaseExecute.h
//  LHNetWorking
//
//  Created by zhao on 16/1/8.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHPredicate;
@interface LHDataBaseExecute : NSObject

@property (nonatomic,strong) NSDateFormatter* dateFormatter;

@property (nonatomic,strong) NSString* sqlPath;

+ (instancetype)dataBaseWith:(NSString*)dataBasePath;

- (instancetype)initWith:(NSString*)sqlPath;

- (BOOL)writeExecuteWith:(NSString*)sqlString;

- (void)readExecuteWith:(NSString*)sqlString success:(void(^)(NSArray* resultArray))success faild:(void(^)(NSError* error))faild;

- (void)readExecuteWith:(NSString *)sqlString WithClass:(Class)class success:(void (^)(NSArray *))success faild:(void (^)(NSError *))faild;

- (void)createTableWithClass:(Class)newClass;

- (void)addColumWith:(Class)newClass columName:(NSString*)propertyName;

- (void)dropTabelWith:(Class)newClass;

- (void)insertWithModel:(id)model;

- (void)insertWithModel:(id)model WithError:(void(^)(NSError* error))error;

- (void)updateWithModel:(id)model predicate:(LHPredicate*)predicate;

- (void)updateWithModel:(id)model predicate:(LHPredicate*)predicate WithError:(void(^)(NSError* error))error;

- (void)deleteWithClass:(Class)class predicate:(LHPredicate*)predicate;

- (void)deleteWithClass:(Class)class predicate:(LHPredicate *)predicate WithError:(void(^)(NSError* error))error;

- (NSArray*)selectFromClass:(Class)class predicate:(LHPredicate*)predicate;

- (NSArray*)selectFromClass:(Class)class predicate:(LHPredicate*)predicate error:(void(^)(NSError* error))error;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com