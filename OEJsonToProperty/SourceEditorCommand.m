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
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    int start = (int)selection.start.line;
    int end  = (int)selection.end.line;
    
    NSMutableString *text = [NSMutableString string];
    
    for (int i=0; i<invocation.buffer.lines.count; i++) {
        NSLog(@"%ld",invocation.buffer.lines.count);
        if (end>=i && i>=start) {
            [text appendString:invocation.buffer.lines[i]];
            invocation.buffer.lines[i] = @"";
        }
    }
    id result = [[ConvertTool shareTool] dictionaryWithJsonStr:text];

    if ([result isKindOfClass:[NSError class]]) {
        NSError *error = result;
        NSLog(@"Error：Json is invalid");
    }else{

        invocation.buffer.lines[start] = [[ConvertTool shareTool] dealClassNameWithJsonResult:result];

    }
    completionHandler(nil);
}





@end
