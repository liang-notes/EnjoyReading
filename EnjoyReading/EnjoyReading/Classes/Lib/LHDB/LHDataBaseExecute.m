//
//  LHDataBaseExecute.m
//  LHNetWorking
//
//  Created by zhao on 16/1/8.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import "LHDataBaseExecute.h"
#import <sqlite3.h>
#import "NSObject+LHModelOperation.h"
#import "LHModelStateMent.h"
#import "LHPredicate.h"
#import <UIKit/UIKit.h>

@interface LHDataBaseExecute()


@end

@implementation LHDataBaseExecute
{
    sqlite3* db;
}
//获取错误信息
static NSError* errorForDataBase(NSString* sqlString,sqlite3* db)
{
    NSError* error = [NSError errorWithDomain:[NSString stringWithUTF8String:sqlite3_errmsg(db)] code:sqlite3_errcode(db) userInfo:@{@"sqlString":sqlString}];
    return error;
}
//获取查询数据
static NSObject* dataWithDataType(int type,sqlite3_stmt * statement,int index)
{
    if (type == SQLITE_INTEGER) {
        int value = sqlite3_column_int(statement, index);
        return [NSNumber numberWithInt:value];
    }else if (type == SQLITE_FLOAT) {
        float value = sqlite3_column_double(statement, index);
        return [NSNumber numberWithFloat:value];
    }else if (type == SQLITE_BLOB) {
        const void *value = sqlite3_column_blob(statement, index);
        int bytes = sqlite3_column_bytes(statement, index);
        return [NSData dataWithBytes:value length:bytes];
    }else if (type == SQLITE_NULL) {
        return nil;
    }else if (type == SQLITE_TEXT) {
        return [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, index)];
    }else {
        return nil;
    }
}

- (instancetype)initWith:(NSString*)sqlPath
{
    self = [super init];
    if (self) {
        self.sqlPath = sqlPath;
    }
    return self;
}

+ (instancetype)dataBaseWith:(NSString*)dataBasePath
{
    LHDataBaseExecute* execute = [[LHDataBaseExecute alloc] initWith:dataBasePath];
    return execute;
}
//打开数据库
- (BOOL)openDB
{
    if (sqlite3_open([self.sqlPath UTF8String], &db) == SQLITE_OK) {
        return YES;
    }else{
        sqlite3_close(db);
        return NO;
    }
}
//写操作
- (BOOL)writeExecuteWith:(NSString*)sqlString
{
    if (![self openDB]) {
        return NO;
    }
    char *err;
    if (sqlite3_exec(db, [sqlString UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        NSLog(@"数据库操作数据失败! 错误信息%@,%@", [NSString stringWithUTF8String:err],sqlString);
        sqlite3_free(err);
        sqlite3_close(db);
        return YES;
    }else{
        sqlite3_free(err);
        sqlite3_close(db);
        return NO;
    }
}


- (void)readExecuteWith:(NSString*)sqlString success:(void(^)(NSArray* resultArray))success faild:(void(^)(NSError* error))faild
{
    if (![self openDB]) {
        faild(errorForDataBase(sqlString,db));
        return;
    }
    sqlite3_stmt * statement;
    NSMutableArray* tempArr = [NSMutableArray array];
    if (sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        int count = sqlite3_column_count(statement);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            for (int i=0; i<count; i++) {
                int type = sqlite3_column_type(statement, i);
                if (![dataWithDataType(type, statement, i) isKindOfClass:[NSNull class]]) {
                    [dic setValue:dataWithDataType(type, statement, i) forKey:[NSString stringWithUTF8String:sqlite3_column_name(statement, i)]];
                }
            }
            [tempArr addObject:dic];
        }
        success(tempArr);
    }else{
        faild(errorForDataBase(sqlString,db));
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
}

- (void)readExecuteWith:(NSString *)sqlString WithClass:(Class)class success:(void (^)(NSArray *))success faild:(void (^)(NSError *))faild
{
    if (![self openDB]) {
        faild(errorForDataBase(sqlString,db));
        return;
    }
    [self readExecuteWith:sqlString success:^(NSArray *resultArray) {
        NSMutableArray* tempArray = [NSMutableArray array];
        for (NSDictionary* dic in resultArray) {
            id objectModel = [class modelWithDictory:dic];
            [tempArray addObject:objectModel];
        }
        success(tempArray);
    } faild:^(NSError *error) {
        faild(error);
    }];
    sqlite3_close(db);
}

- (void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt*)pStmt {
    
    if ((!obj) || ((NSNull *)obj == [NSNull null])) {
        sqlite3_bind_null(pStmt, idx);
    }
    
    // FIXME - someday check the return codes on these binds.
    else if ([obj isKindOfClass:[NSData class]]) {
        const void *bytes = [obj bytes];
        if (!bytes) {
            // it's an empty NSData object, aka [NSData data].
            // Don't pass a NULL pointer, or sqlite will bind a SQL null instead of a blob.
            bytes = "";
        }
        sqlite3_bind_blob(pStmt, idx, bytes, (int)[obj length], SQLITE_STATIC);
    }
    else if ([obj isKindOfClass:[NSDate class]]) {
        if (self.dateFormatter)
            sqlite3_bind_text(pStmt, idx, [[self.dateFormatter stringFromDate:obj] UTF8String], -1, SQLITE_STATIC);
        else
            sqlite3_bind_text(pStmt, idx, [[self stringFromDate:obj] UTF8String],-1,SQLITE_STATIC);
    }
    else if ([obj isKindOfClass:[NSNumber class]]) {
        
        if (strcmp([obj objCType], @encode(char)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj charValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned char)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj unsignedCharValue]);
        }
        else if (strcmp([obj objCType], @encode(short)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj shortValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned short)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj unsignedShortValue]);
        }
        else if (strcmp([obj objCType], @encode(int)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj intValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned int)) == 0) {
            sqlite3_bind_int64(pStmt, idx, (long long)[obj unsignedIntValue]);
        }
        else if (strcmp([obj objCType], @encode(long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, (long long)[obj unsignedLongValue]);
        }
        else if (strcmp([obj objCType], @encode(long long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longLongValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned long long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, (long long)[obj unsignedLongLongValue]);
        }
        else if (strcmp([obj objCType], @encode(float)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj floatValue]);
        }
        else if (strcmp([obj objCType], @encode(double)) == 0) {
            NSLog(@"%f",[obj doubleValue]);
            sqlite3_bind_double(pStmt, idx, [obj doubleValue]);
        }
        else if (strcmp([obj objCType], @encode(BOOL)) == 0) {
            sqlite3_bind_int(pStmt, idx, ([obj boolValue] ? 1 : 0));
        }
        else {
            sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
        }
    }
    else if ([obj isKindOfClass:[NSArray class]]||[obj isKindOfClass:[NSDictionary class]]) {
        @try {
            NSData* data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
            NSString* jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            sqlite3_bind_text(pStmt, idx, [[jsonStr description] UTF8String], -1, SQLITE_STATIC);
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }else if ([obj isKindOfClass:NSClassFromString(@"UIImage")]) {
        NSData* data = UIImagePNGRepresentation(obj);
        const void *bytes = [data bytes];
        if (!bytes) {
            // it's an empty NSData object, aka [NSData data].
            // Don't pass a NULL pointer, or sqlite will bind a SQL null instead of a blob.
            bytes = "";
        }
        sqlite3_bind_blob(pStmt, idx, bytes, (int)[data length], SQLITE_STATIC);
    }
    else {
        sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
    }
}

- (NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

- (void)executeWith:(NSString*)sqlString model:(id)model error:(void(^)(NSError* error))error
{
    NSDictionary* valueDic = [model getDic];
    if (![self openDB]) {
        if (error) {
            error(errorForDataBase(sqlString, db));
        }
        return;
    }
    sqlite3_stmt* stmt;
    if (sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &stmt, NULL)!=SQLITE_OK) {
        if (error) {
            error(errorForDataBase(sqlString, db));
        }        sqlite3_finalize(stmt);
        return;
    }
    for (int i=0; i<valueDic.allKeys.count; i++) {
        [self bindObject:valueDic[valueDic.allKeys[i]] toColumn:i+1 inStatement:stmt];
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        if (error) {
            error(errorForDataBase(sqlString, db));
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
}

- (void)createTableWithClass:(Class)newClass
{
    NSString* sql = createTableString(newClass);
    [self writeExecuteWith:sql];
}

- (void)dropTabelWith:(Class)newClass
{
    NSString* sql = [NSString stringWithFormat:@"DROP TABLE %@",NSStringFromClass(newClass)];
    [self writeExecuteWith:sql];
}

- (void)addColumWith:(Class)newClass columName:(NSString*)propertyName
{
    NSString* sqlString = [NSString stringWithFormat:@"alter table %@ add %@ %@",NSStringFromClass(newClass),propertyName,[self getTypeNameWith:propertyName]];
    [self writeExecuteWith:sqlString];
}

- (void)insertWithModel:(id)model
{
    NSString* insertSql = insertString(model);
    [self executeWith:insertSql model:model error:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)insertWithModel:(id)model WithError:(void(^)(NSError* error))error
{
    NSString* insertSql = insertString(model);
    [self executeWith:insertSql model:model error:error];
}

- (void)updateWithModel:(id)model predicate:(LHPredicate*)predicate
{
    NSString* sqlString = updateString(model, predicate);
    [self executeWith:sqlString model:model error:^(NSError *error) {
        
    }];
}

- (void)updateWithModel:(id)model predicate:(LHPredicate*)predicate WithError:(void(^)(NSError* error))error
{
    NSString* sqlString = updateString(model, predicate);
    [self executeWith:sqlString model:model error:error];
}

- (void)deleteWithClass:(Class)class predicate:(LHPredicate*)predicate
{
    NSString* deleteSql = deleteString(class, predicate);
    [self executeWith:deleteSql model:nil error:nil];
}

- (void)deleteWithClass:(Class)class predicate:(LHPredicate *)predicate WithError:(void(^)(NSError* error))error
{
    NSString* deleteSql = deleteString(class, predicate);
    [self executeWith:deleteSql model:nil error:error];
}

- (NSArray*)selectFromClass:(Class)class predicate:(LHPredicate*)predicate
{
    NSMutableArray* resultArray = [NSMutableArray array];
    NSDictionary* typeDic = [class getAllPropertyNameAndType];
    NSString* sqlString = selectString(class, predicate);
    if (![self openDB]) {
        return nil;
    }
    sqlite3_stmt* statement;
    if (sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &statement, NULL)!=SQLITE_OK) {
        sqlite3_finalize(statement);
        return nil;
    }
    int count = sqlite3_column_count(statement);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        id model = [[class alloc] init];
        for (int i=0; i<count; i++) {
            int type = sqlite3_column_type(statement, i);
            NSString* columnType = [NSString stringWithUTF8String:sqlite3_column_decltype(statement, i)] ;
            if (type == SQLITE_TEXT&& [columnType isEqualToString:@"INT"]) {
                type = SQLITE_FLOAT;
            }
            if (![dataWithDataType(type, statement, i) isKindOfClass:[NSNull class]]) {
                NSString* propertyName = [NSString stringWithUTF8String:sqlite3_column_name(statement, i)];
                NSObject* value = dataWithDataType(type, statement, i);
                [model setValue:value propertyName:propertyName propertyType:typeDic[propertyName]];
            }
        }
        [resultArray addObject:model];
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return  resultArray;
}

- (NSArray*)selectFromClass:(Class)class predicate:(LHPredicate*)predicate error:(void(^)(NSError* error))error
{
    NSMutableArray* resultArray = [NSMutableArray array];
    NSDictionary* typeDic = [class getAllPropertyNameAndType];
    NSString* sqlString = selectString(class, predicate);
    if (![self openDB]) {
        if (error) {
            error(errorForDataBase(sqlString, db));
        }
        return nil;
    }
    sqlite3_stmt* statement;
    if (sqlite3_prepare_v2(db, [sqlString UTF8String], -1, &statement, NULL)!=SQLITE_OK) {
        if (error) {
            error(errorForDataBase(sqlString, db));
        }
        sqlite3_finalize(statement);
        return nil;
    }
    int count = sqlite3_column_count(statement);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        id model = [[class alloc] init];
        for (int i=0; i<count; i++) {
            int type = sqlite3_column_type(statement, i);
            NSString* columnType = [NSString stringWithUTF8String:sqlite3_column_decltype(statement, i)] ;
            if (type == SQLITE_TEXT&& [columnType isEqualToString:@"INT"]) {
                type = SQLITE_FLOAT;
            }
            if (![dataWithDataType(type, statement, i) isKindOfClass:[NSNull class]]) {
                NSString* propertyName = [NSString stringWithUTF8String:sqlite3_column_name(statement, i)];
                NSObject* value = dataWithDataType(type, statement, i);
                [model setValue:value propertyName:propertyName propertyType:typeDic[propertyName]];
            }
        }
        [resultArray addObject:model];
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return  resultArray;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com