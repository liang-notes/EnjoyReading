//
//  ERFood.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodList.h"

@implementation ERFoodList
+ (instancetype)foodListWithDict:(NSDictionary *)dict
{
    ERFoodList *foodList = [[self alloc] init];
    foodList.name = dict[@"name"];
    foodList.icon = dict[@"img"] ;
    foodList.foodDescription = dict[@"description"];
    foodList.keywords = dict[@"keywords"];
    foodList.food = dict[@"food"];
    return foodList;
}

- (void)setFood:(NSString *)food
{
    _food = [NSString stringWithFormat:@"材料:%@",food];
}

- (void)setFoodDescription:(NSString *)foodDescription
{
    _foodDescription = [NSString stringWithFormat:@"做法:\n%@",foodDescription];
}
@end
