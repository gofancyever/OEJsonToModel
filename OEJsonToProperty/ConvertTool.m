//
//  ConvertTool.m
//  xTextHandler
//
//  Created by gaof on 2016/11/1.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "ConvertTool.h"
#import "JsonModel.h"
@implementation ConvertTool


-(NSArray *)convertWithDict:(NSDictionary *)dict {
    NSMutableArray *arrayM = [NSMutableArray array];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        JsonModel *jsonModel = [[JsonModel alloc] initWithKey:key value:obj];
        [arrayM addObject:jsonModel];
    }];
    return arrayM;
}
@end
