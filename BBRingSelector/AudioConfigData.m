//
//  AudioConfigData.m
//  
//
//  Created by 大钟威武 on 13-12-11.
//  Copyright (c) 2013年 bigbelldev.com. All rights reserved.
//

#import "AudioConfigData.h"

@implementation AudioConfigData
// 配置数据
// 要求audio文件命名规则是XX_20s.caf，在下面的配置中，只保留xx_20s
+ (NSDictionary *)longAudioConfigListDict
{
    return [NSDictionary dictionaryWithObjects:@[
                                                 @"piano_8s",
                                                 ] forKeys:@[
                                                             @"钢琴",
                                                             ]];
}

+ (NSDictionary *)shortAudioConfigListDict
{
    return [NSDictionary dictionaryWithObjects:@[
                                                 @"ding_7s",
                                                 @"systemdefault_1s",
                                                 ] forKeys:@[
                                                             @"叮~",
                                                             @"经典三全音",
                                                             ]];
}

+ (NSString *)getSectionName:(NSInteger)section
{
    if (section >= 0) {
        return @[@"section 0", @"section 1"][section];
    }
    return @"error";
}



+ (NSDictionary *)getAudioConfigList
{
    NSArray *valueArray = [[[self longAudioConfigListDict] allValues] arrayByAddingObjectsFromArray:[[self shortAudioConfigListDict] allValues]];
    NSArray *keyArray = [[[self longAudioConfigListDict] allKeys] arrayByAddingObjectsFromArray:[[self shortAudioConfigListDict] allKeys]];
    NSDictionary *audioListDict = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
    return audioListDict;
}

+ (NSString *)getSecondsFromAudioName:(NSString *)name
{
    NSArray *splitResult = [name componentsSeparatedByString:@"_"];
    
    return [splitResult lastObject];
}

+ (NSString *)getPathForResourceUsingKey:(NSString *)key
{
    return [[self getAudioConfigList] objectForKey:key];
}

@end
