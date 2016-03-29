//
//  LHModelStateMent.m
//  LHDBDemo
//
//  Created by 3wchina01 on 16/1/25.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import "LHModelStateMent.h"
#import "NSObject+LHModelOperation.h"
#import "LHPredicate.h"

#define CREATE_TABLENAME_HEADER @"CREATE TABLE IF NOT EXISTS "
#define INSERT_HEADER @"INSERT INTO "
#define UPDATE_HEADER @"UPDATE "
#define DELETE_HEADER @"DELETE FROM "
#define SELECT_HEADER @"SELECT * FROM "


@implementation LHModelStateMent

static NSString* tableNameValueString(NSString* type,NSString* name)
{
    NSString* finalStr = @",";
    NSString* typeStr = (NSString*)type;
    if ([typeStr isEqualToString:@"i"]) {
        return [NSString stringWithFormat:@"%@ %@%@",name,@"INT",finalStr];
    }else if ([typeStr isEqualToString:@"f"]) {
        return [NSString stringWithFormat:@"%@ %@%@",name,@"FLOAT",finalStr];
    }else if ([typeStr isEqualToString:@"B"]) {
        return [NSString stringWithFormat:@"%@ %@%@",name,@"BOOL",finalStr];
    }else if ([typeStr isEqualToString:@"d"]) {
        return [NSString stringWithFormat:@"%@ %@%@",name,@"DOUBLE",finalStr];
    }else if ([typeStr isEqualToString:@"q"]) {
        return [NSString stringWithFormat:@"%@ %@%@",name,@"LONG",finalStr];
    }else if ([typeStr isEqualToString:@"NSData"]||[typeStr isEqualToString:@"UIImage"]) {
        return [NSString stringWithFormat:@"%@ %@%@",name,@"BLOB",finalStr];
    }else if ([typeStr isEqualToString:@"NSNumber"]){
        return [NSString stringWithFormat:@"%@ %@%@",name,@"INT",finalStr];
    } else
        return [NSString stringWithFormat:@"%@ %@%@",name,@"TEXT",finalStr];
}

static NSDictionary* insertValueString(id value,NSString* name,NSString* type)
{
    if ([value isKindOfClass:[NSNumber class]]) {
        return @{name:@"?"};
    }else if ([type isEqualToString:@"UIImage"]) {
        return @{name:@"?"};
    }else
        return @{name:@"?"};
}

static NSString* updateSQL(NSArray* value)
{
    NSMutableString* string = [NSMutableString string];
    for (NSString* propertyName in value) {
        [string appendFormat:@" %@ = ?,",propertyName];
    }
    if (string.length>0) {
        [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
    }
    return string;
}

NSString* createTableString(Class modelClass)
{
    NSMutableString* sqlString = [NSMutableString stringWithString:CREATE_TABLENAME_HEADER];
    NSDictionary* stateMentDic = [modelClass getAllPropertyNameAndType];
    [sqlString appendString:NSStringFromClass(modelClass)];
    NSMutableString* valueStr = [NSMutableString string];
    [stateMentDic enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL* stop) {
        [valueStr appendString:tableNameValueString(obj, key)];
    }];
    if (valueStr.length>0) {
        [valueStr deleteCharactersInRange:NSMakeRange(valueStr.length-1, 1)];
    }
    [sqlString appendFormat:@"(%@)",valueStr];
    return sqlString;
}

NSString* insertString(id model)
{
    NSMutableString* sqlString = [NSMutableString stringWithString:INSERT_HEADER];
    [sqlString appendString:NSStringFromClass([model class])];
    NSDictionary* valueDic = [model getDic];
    NSDictionary* typeDic = [model getAllPropertyNameAndType];
    NSMutableString* keyStr = [NSMutableString string];
    NSMutableString* valueStr = [NSMutableString string];
    for (int i=0; i<valueDic.allKeys.count; i++) {
        NSDictionary* dic = insertValueString(valueDic[valueDic.allKeys[i]], valueDic.allKeys[i], typeDic[valueDic.allKeys[i]]);
        [keyStr appendFormat:@"%@,",dic.allKeys[0]];
        [valueStr appendFormat:@"%@,",dic[dic.allKeys[0]]];
    }
    [sqlString appendFormat:@"(%@) VALUES (%@)",[keyStr substringToIndex:keyStr.length-1],[valueStr substringToIndex:valueStr.length-1]];
    return sqlString;
}

NSString* updateString(id model,LHPredicate* predicate)
{
    NSMutableString* updateSql = [NSMutableString stringWithString:UPDATE_HEADER];
    [updateSql appendFormat:@"%@ set",NSStringFromClass([model class])];
    [updateSql appendFormat:@"%@",updateSQL([model getDic].allKeys)];
    [updateSql appendFormat:@" WHERE %@",predicate.predicateFormat];
    return updateSql;
}

NSString* deleteString(Class modelClass,LHPredicate* predicate)
{
    NSMutableString* deleteStr = [NSMutableString stringWithString:DELETE_HEADER];
   
    [deleteStr appendString:NSStringFromClass(modelClass)];
    if (predicate.predicateFormat) {
        [deleteStr appendFormat:@" %@",predicate.predicateFormat];
    }
    return deleteStr;
}

NSString* selectString(Class modelClass,LHPredicate* predicate)
{
    NSMutableString* selectStr = [NSMutableString stringWithString:SELECT_HEADER];
    [selectStr appendString:NSStringFromClass(modelClass)];
    if (predicate.predicateFormat) {
        [selectStr appendFormat:@" WHERE %@",predicate.predicateFormat];
    }
    if (predicate.sortString) {
        [selectStr appendFormat:@" ORDER BY %@",predicate.sortString];
    }
    return selectStr;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com