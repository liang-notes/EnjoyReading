//
//  LHDBQueue.h
//  LHNetWorking
//
//  Created by zhao on 16/1/8.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ErrorQueue(callback) dispatch_async(dispatch_get_global_queue(0, 0), ^{\
(callback);\
})

#define WEAKSELF typeof(self) __weak weakSelf = self;

typedef void(^executeError)(NSError* error);

@class LHPredicate;
@interface LHDBQueue : NSObject
@property (nonatomic,strong) NSString* sqlPath;

//+ (instancetype)instanceManager;

+ (instancetype)instanceManagerWith:(NSString*)dataBasePath;
//所有写操作
- (void)writeOperationWith:(NSString*)sqlString;
//读操作(返回值以字典表示)
- (void)readOpeartionWith:(NSString*)sqlString success:(void(^)(NSArray* resultArray))success faild:(void(^)(NSError* error))faild;
//读操作(返回值以model表示)
- (void)readOpeartionWith:(NSString*)sqlString class:(Class)class success:(void(^)(NSArray* resultArray))success faild:(void(^)(NSError* error))faild;
#pragma mark-  不在队列中执行
/*
    创建表，LHDB会根据传入的类所有的属性名创建字段
*/
- (void)createTableWithClass:(Class)newClass;

/*
    如果在一个建好的表中需要增加字段，需要调用此方法，传入类和类增加的字段
 */
- (void)addColumWith:(Class)newClass columName:(NSString*)propertyName;

/*
    插入数据，LHDB内部会解析传入的model，并生产sql语句插入数据库
*/

- (void)insertModel:(id)model;

/*
    如果需要错误信息，在执行插入操作如果失败时会回调block
*/

- (void)insertModel:(id)model error:(executeError)error;

/*
    更新操作，将传入的model更新到数据库，predicate是谓词，表示更新的范围
*/

- (void)updateModel:(id)model predicate:(LHPredicate*)predicate;

- (void)updateModel:(id)model predicate:(LHPredicate*)predicate error:(executeError)error;
/*
    根据类删除数据
 */
- (void)deleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate;

- (void)deleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate error:(executeError)error;

/*
    查询操作
 */
- (NSArray*)selectModel:(Class)class predicate:(LHPredicate*)predicate;

- (NSArray*)selectModel:(Class)class predicate:(LHPredicate *)predicate error:(executeError)error;

#pragma mark-  在队列中执行(线程安全)
/*
 需要跑多线程时，为了防止数据库锁住，建议使用以下方法
 */

/*
 在队列中执行建表方法
 */
- (void)inQueueCreateTableWithClass:(Class)newClass;

- (void)inQueueAddColumWith:(Class)newClass columName:(NSString*)propertyName;
/*
 下面所有操作错误的回调全部在子线程中，如果需要更新UI请跳转到主线程
 */
- (void)inQueueInsertModel:(id)model;

- (void)inQueueInsertModel:(id)model error:(executeError)fail;

- (void)inQueueUpdateModel:(id)model predicate:(LHPredicate*)predicate;

- (void)inQueueUpdateModel:(id)model predicate:(LHPredicate*)predicate error:(executeError)fail;

- (void)inQueueDeleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate;

- (void)inQueueDeleteWithClass:(Class)modelClass predicate:(LHPredicate *)predicate error:(executeError)fail;

- (void)inQueueSelectModel:(Class)class predicate:(LHPredicate*)predicate result:(void(^)(NSArray* resultArray))result;
- (void)inQueueSelectModel:(Class)class predicate:(LHPredicate*)predicate result:(void(^)(NSArray* resultArray))result error:(executeError)fail;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com