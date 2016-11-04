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

+ (instancetype)shareTool {
    return [[self alloc] init];
}
static id _instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if(_instance == nil){
        _instance = [super allocWithZone:zone];
    }
    return _instance;
}
- (instancetype) init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}

-(NSArray *)convertWithDict:(NSDictionary *)dict {
    NSMutableArray *arrayM = [NSMutableArray array];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        JsonModel *jsonModel = [[JsonModel alloc] initWithKey:key value:obj];
        [arrayM addObject:jsonModel];
    }];
    return arrayM;
}

/**
 *  检查是否是一个有效的JSON 并格式化
 */
-(id)dictionaryWithJsonStr:(NSString *)jsonString{
    jsonString = [[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    //中文标点
//    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"“" withString:@"\"" options:NSRegularExpressionSearch range:NSMakeRange(0, jsonString.length)];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"，" withString:@","];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"：" withString:@":"];
    //去除多余 ，号
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@"" ];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@",}" withString:@"}"];
    NSLog(@"jsonString=%@",jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dicOrArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&err];
    if (err) {
        return err;
    }else{
        return dicOrArray;
    }
    
}

- (NSString *)dealClassNameWithJsonResult:(id)result {
    if ([result isKindOfClass:[NSDictionary class]]) {
        //遍历字典 生成对应属性
        ConvertTool *tool = [[ConvertTool alloc] init];
        NSArray *modelArr = [tool convertWithDict:result];
        NSMutableString *resultStr = [NSMutableString string];
        for (JsonModel *model in modelArr) {
            NSString *propertyStr = [NSString stringWithFormat:@"%@%;@\n",model.propertyClass,model.propertyName];
            [resultStr appendString:propertyStr];
        }
        return resultStr;
    }
    else if ([result isKindOfClass:[NSArray class]]) {
        return  @"";
    }
    else{
        return  @"";
    }
}
@end
