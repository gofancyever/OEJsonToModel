//
//  SourceEditorCommand.m
//  OEJsonToProperty
//
//  Created by apple on 2016/11/2.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "ConvertTool.h"
#import "JsonModel.h"
@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    NSString *text = [invocation.buffer.lines firstObject];
    id result = [self dictionaryWithJsonStr:text];
    if ([result isKindOfClass:[NSError class]]) {
        NSError *error = result;
        NSLog(@"Error：Json is invalid");
    }else{
        invocation.buffer.lines[0] = [self dealClassNameWithJsonResult:result];
    }

    
    
    completionHandler(nil);
}

- (NSString *)dealClassNameWithJsonResult:(id)result {
    if ([result isKindOfClass:[NSDictionary class]]) {
        //遍历字典 生成对应属性
        ConvertTool *tool = [[ConvertTool alloc] init];
        NSArray *modelArr = [tool convertWithDict:result];
        NSMutableString *resultStr = [NSMutableString string];
        for (JsonModel *model in modelArr) {
            NSString *propertyStr = [NSString stringWithFormat:@"%@%@\n",model.propertyClass,model.propertyName];
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


/**
 *  检查是否是一个有效的JSON
 */
-(id)dictionaryWithJsonStr:(NSString *)jsonString{
    jsonString = [[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
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
@end
