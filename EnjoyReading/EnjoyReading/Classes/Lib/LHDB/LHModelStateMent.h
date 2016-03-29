//
//  LHModelStateMent.h
//  LHDBDemo
//
//  Created by 3wchina01 on 16/1/25.
//  Copyright © 2016年 李浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHPredicate;
@interface LHModelStateMent : NSObject

NSString* createTableString(Class modelClass);

NSString* insertString(id model);

NSString* updateString(id model,LHPredicate* predicate);

NSString* deleteString(Class modelClass,LHPredicate* predicate);

NSString* selectString(Class modelClass,LHPredicate* predicate);

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com