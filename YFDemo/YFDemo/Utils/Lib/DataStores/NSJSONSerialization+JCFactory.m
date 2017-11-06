//
//  NSJSONSerialization+JCFactory.m
//  JCCompositionLib
//
//  Created by Cerko on 17/1/17.
//  Copyright © 2017年 Cerko. All rights reserved.
//

#import "NSJSONSerialization+JCFactory.h"

@implementation NSString (UTF8String)

+ (instancetype)UTF8StringWithData:(NSData *)data{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end


@implementation NSJSONSerialization (JCFactory)


+ (nullable id)JSONObjectWithData:(NSData *)data{
    NSError *error = nil;
    
    id dic = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&error];
    
    if (error) {
        NSLog(@"data:%@ json parse to data error :%@",data, error);
    }
    return dic;

}

+ (nullable id)JSONObjectWithUTF8EncodingString:(NSString *)string{
    return [self JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (nullable NSData *)dataWithJSONObject:(id)obj{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
    if (error) {
        NSLog(@"obj:%@ parse to json data  error :%@",obj, data);
    }
    
    return data;

}

+ (nullable NSString *)stringUsingUTF8EncodingWithJSONObject:(id)obj{
    return [NSString UTF8StringWithData:[self dataWithJSONObject:obj]];
}



@end


NSString *JSONObjectToString(id jsonData){
    if ([jsonData isKindOfClass:[NSString class]]) {
        return jsonData;
    }
    
    if ([jsonData isKindOfClass:[NSData class]]) {
        return [NSString UTF8StringWithData:jsonData];
    }
    
    return [NSJSONSerialization stringUsingUTF8EncodingWithJSONObject:jsonData];
}

id stringToJSONObject(NSString *string){
    id obj = [NSJSONSerialization JSONObjectWithUTF8EncodingString:string];
    if (obj) {
        return obj;
    }
    return string;
}

