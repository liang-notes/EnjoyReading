//
//  LHDBQueue.m
//  LHNetWorking
//
//  Created by zhao on 16/1/8.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import "LHDBQueue.h"
#import "LHDataBaseExecute.h"
#import "LHPredicate.h"

#define LHQUEUE "LHQUEUE"




@interface LHDBQueue()

@property (nonatomic,strong) dispatch_queue_t mainQueue;
@property (nonatomic,strong) LHDataBaseExecute* execute;

@end

@implementation LHDBQueue

+ (instancetype)instanceManager
{
    static LHDBQueue* queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[self alloc] init];
        queue.mainQueue = dispatch_queue_create(LHQUEUE,DISPATCH_QUEUE_SERIAL);;
    });
    return queue;
}

+ (instancetype)instanceManagerWith:(NSString*)dataBasePath
{
    static LHDBQueue* queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[self alloc] init];
        queue.mainQueue = dispatch_queue_create(LHQUEUE,DISPATCH_QUEUE_SERIAL);;
    });
    queue.sqlPath = dataBasePath;
    return queue;
}

- (void)setSqlPath:(NSString *)sqlPath
{
    if (self.execute) {
        if (![self.execute.sqlPath isEqualToString:sqlPath]) {
            self.execute.sqlPath = sqlPath;
        }
    }else
        self.execute = [LHDataBaseExecute dataBaseWith:sqlPath];
}


- (void)writeOperationWith:(NSString*)sqlString
{
    dispatch_sync(self.mainQueue, ^{
        [self.execute writeExecuteWith:sqlString];
    });
}

- (void)readOpeartionWith:(NSString*)sqlString success:(void(^)(NSArray* resultArray))success faild:(void(^)(NSError* error))faild
{
    dispatch_sync(self.mainQueue, ^{
        [self.execute readExecuteWith:sqlString success:^(NSArray *resultArray) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                success(resultArray);
            });
        } faild:^(NSError *error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                faild(error);
            });
        }];
    });
}

- (void)readOpeartionWith:(NSString*)sqlString class:(Class)class success:(void(^)(NSArray* resultArray))success faild:(void(^)(NSError* error))faild
{
    dispatch_sync(self.mainQueue, ^{
        [self.execute readExecuteWith:sqlString WithClass:class success:success faild:faild];
    });
}

- (void)createTableWithClass:(Class)newClass
{
    [self.execute createTableWithClass:newClass];
}

- (void)addColumWith:(Class)newClass columName:(NSString*)propertyName
{
    [self.execute addColumWith:newClass columName:propertyName];
}

- (void)insertModel:(id)model
{
    [self.execute insertWithModel:model];
}

- (void)insertModel:(id)model error:(executeError)error
{
    [self.execute insertWithModel:model WithError:error];
}

- (void)updateModel:(id)model predicate:(LHPredicate*)predicate
{
    [self.execute updateWithModel:model predicate:predicate];
}

- (void)updateModel:(id)model predicate:(LHPredicate*)predicate error:(executeError)error
{
    [self.execute updateWithModel:model predicate:predicate WithError:error];
}

- (void)deleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate
{
    [self.execute deleteWithClass:modelClass predicate:predicate];
}

- (void)deleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate error:(executeError)error
{
    [self.execute deleteWithClass:modelClass predicate:predicate WithError:error];
}

- (NSArray*)selectModel:(Class)class predicate:(LHPredicate*)predicate
{
    return [self.execute selectFromClass:class predicate:predicate];
}

- (NSArray*)selectModel:(Class)class predicate:(LHPredicate *)predicate error:(executeError)error
{
    return [self.execute selectFromClass:class predicate:predicate error:error];
}

- (void)inQueueCreateTableWithClass:(Class)newClass
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute  createTableWithClass:newClass];
    });
}

- (void)inQueueAddColumWith:(Class)newClass columName:(NSString*)propertyName
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute addColumWith:newClass columName:propertyName];
    });
}

- (void)inQueueInsertModel:(id)model
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute insertWithModel:model];
    });
}

- (void)inQueueInsertModel:(id)model error:(executeError)fail
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute insertWithModel:model WithError:^(NSError *error) {
            ErrorQueue(fail(error));
        }];
    });
}

- (void)inQueueUpdateModel:(id)model predicate:(LHPredicate*)predicate
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute updateWithModel:model predicate:predicate];
    });
}

- (void)inQueueUpdateModel:(id)model predicate:(LHPredicate*)predicate error:(executeError)fail
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute updateWithModel:model predicate:predicate WithError:^(NSError *error) {
            ErrorQueue(fail(error));
        }];
    });
}

- (void)inQueueDeleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute deleteWithClass:modelClass predicate:predicate];
    });
}

- (void)inQueueDeleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate error:(executeError)fail
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        [weakSelf.execute deleteWithClass:modelClass predicate:predicate WithError:^(NSError *error) {
            ErrorQueue(fail(error));
        }];
    });
}

- (void)inQueueSelectModel:(Class)class predicate:(LHPredicate*)predicate result:(void(^)(NSArray* resultArray))result
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
       NSArray* array = [weakSelf.execute selectFromClass:class predicate:predicate];
        ErrorQueue(result(array));
    });
}

- (void)inQueueSelectModel:(Class)class predicate:(LHPredicate*)predicate result:(void(^)(NSArray* resultArray))result error:(executeError)fail
{
    WEAKSELF;
    dispatch_async(self.mainQueue, ^{
        NSArray* array = [weakSelf.execute selectFromClass:class predicate:predicate error:^(NSError *error) {
            ErrorQueue(fail(error));
        }];
        ErrorQueue(result(array));
    });
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com