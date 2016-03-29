//
//  NSObject+LHModelExecute.m
//  LHDBDemo
//
//  Created by 3wchina01 on 16/2/15.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import "NSObject+LHDB.h"
#import "LHDataBaseExecute.h"
#import "LHPredicate.h"
#import <objc/runtime.h>
#import "LHDBQueue.h"
#import "LHDBPath.h"



#define DatabasePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"data.sqlite"];

static NSString* const DatabaseFilePath = @"DatabaseFilePath";
static NSString* const DataBaseExecute = @"DataBaseExecute";
static NSString* const DataBaseQueue = @"DataBaseQueue";

@implementation NSObject (LHDB)

- (NSString*)dbPath
{
    if ([LHDBPath instanceManagerWith:nil].dbPath.length == 0) {
        return DatabasePath;
    }else
        return [LHDBPath instanceManagerWith:nil].dbPath;
}

+ (NSString*)dbPath
{
    if ([LHDBPath instanceManagerWith:nil].dbPath.length == 0) {
        return DatabasePath;
    }else
        return [LHDBPath instanceManagerWith:nil].dbPath;
}

- (void)setFilePath:(NSString *)filePath
{
    objc_setAssociatedObject(self, &DatabaseFilePath, filePath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)filePath
{
    return objc_getAssociatedObject(self, &DatabaseFilePath);
}

- (void)setExecute:(LHDataBaseExecute *)execute
{
    objc_setAssociatedObject(self, &DataBaseExecute, execute, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LHDataBaseExecute*)execute
{
    LHDataBaseExecute* theExecute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    [self setExecute:theExecute];
   return objc_getAssociatedObject(self, &DataBaseExecute);
}

- (void)setQueue:(LHDBQueue *)queue
{
    objc_setAssociatedObject(self, &DataBaseQueue, queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LHDBQueue*)queue
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [self setQueue:queue];
    return objc_getAssociatedObject(self, &DataBaseQueue);
}

+ (void)createTable
{
    LHDataBaseExecute* execute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    [execute createTableWithClass:self];
}

+ (void)addColum:(NSString*)name
{
    LHDataBaseExecute* execute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    [execute addColumWith:self columName:name];
}

- (void)save
{
    [self.execute insertWithModel:self];
}

- (void)saveWithIfError:(executeError)error
{
    [self.execute insertWithModel:self WithError:error];
}

- (void)updateWithPredicate:(LHPredicate*)predicate
{
    [self.execute updateWithModel:self predicate:predicate];
}

- (void)updateWithPredicate:(LHPredicate*)predicate error:(executeError)error
{
    [self.execute updateWithModel:self predicate:predicate WithError:error];
}

+ (void)deleteWithPredicate:(LHPredicate*)predicate
{
    LHDataBaseExecute* execute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    [execute deleteWithClass:self predicate:predicate];
}

+ (void)deleteWithPredicate:(LHPredicate*)predicate error:(executeError)error
{
    LHDataBaseExecute* execute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    [execute deleteWithClass:self predicate:predicate WithError:error];
}

+ (NSArray*)selectWithPredicate:(LHPredicate*)predicate
{
    LHDataBaseExecute* execute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    return [execute selectFromClass:self predicate:predicate];
}

+ (NSArray*)selectWithPredicate:(LHPredicate*)predicate error:(executeError)error
{
    LHDataBaseExecute* execute = [LHDataBaseExecute dataBaseWith:[self dbPath]];
    return [execute selectFromClass:self predicate:predicate error:error];
}

+ (void)inQueueCreateTable
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [queue inQueueCreateTableWithClass:self];
}

+ (void)inQueueAddColum:(NSString*)name
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [queue addColumWith:self columName:name];
}

- (void)inQueueSave
{
    [self.queue inQueueInsertModel:self];
}

- (void)inQueueSaveWithIfError:(executeError)fail
{
    [self.queue inQueueInsertModel:self error:^(NSError *error) {
        fail(error);
    }];
}

- (void)inQueueUpdateWithPredicate:(LHPredicate*)predicate
{
    [self.queue inQueueUpdateModel:self predicate:predicate];
}

- (void)inQueueUpdateWithPredicate:(LHPredicate*)predicate error:(executeError)fail
{
    [self.queue inQueueUpdateModel:self predicate:predicate error:^(NSError *error) {
        fail(error);
    }];
}

+ (void)inQueueDeleteWithPredicate:(LHPredicate*)predicate
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [queue inQueueDeleteWithClass:self predicate:predicate];
}

+ (void)inQueueDeleteWithPredicate:(LHPredicate*)predicate error:(executeError)fail
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [queue inQueueDeleteWithClass:self predicate:predicate error:^(NSError *error) {
        fail(error);
    }];
}

+ (void)inQueueSelectWithPredicate:(LHPredicate*)predicate result:(void(^)(NSArray* resultArray))result
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [queue inQueueSelectModel:self predicate:predicate result:^(NSArray *resultArray) {
       result(resultArray);
    }];
}

+ (void)inQueueSelectWithPredicate:(LHPredicate*)predicate result:(void(^)(NSArray* resultArray))result error:(executeError)fail
{
    LHDBQueue* queue = [LHDBQueue instanceManagerWith:[self dbPath]];
    [queue inQueueSelectModel:self predicate:predicate result:^(NSArray *resultArray) {
        result(resultArray);
    } error:^(NSError *error) {
        fail(error);
    }];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com