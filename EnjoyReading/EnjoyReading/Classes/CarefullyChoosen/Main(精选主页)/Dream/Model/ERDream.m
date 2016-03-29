//
//  ERDream.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERDream.h"

@implementation ERDream

- (void)setContent:(NSString *)content
{
    _content = [content copy];   
    NSString *ss = [content stringByReplacingOccurrencesOfString:@"<div>" withString:@"       "];
    ss = [ss stringByReplacingOccurrencesOfString:@"</div>" withString:@"       "];
    ss = [ss stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    _content = ss;
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineSpacing = 50;
//    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
//    NSAttributedString *text = [[NSAttributedString alloc]initWithString:ss attributes:attributes];
}
@end
