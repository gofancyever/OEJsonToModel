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
    id result = [[ConvertTool shareTool] dictionaryWithJsonStr:text];
    if ([result isKindOfClass:[NSError class]]) {
        NSError *error = result;
        NSLog(@"Error：Json is invalid");
    }else{
        invocation.buffer.lines[0] = [[ConvertTool shareTool] dealClassNameWithJsonResult:result];
    }
    completionHandler(nil);
}




@end
