//
//  AudioConfigData.h
//  
//
//  Created by 大钟威武 on 13-12-11.
//  Copyright (c) 2013年 bigbelldev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioConfigData : NSObject
+ (NSDictionary *)getAudioConfigList;
+ (NSDictionary *)longAudioConfigListDict;
+ (NSDictionary *)shortAudioConfigListDict;
+ (NSString *)getSectionName:(NSInteger)section;
+ (NSString *)getSecondsFromAudioName:(NSString *)name;
+ (NSString *)getPathForResourceUsingKey:(NSString *)key;


@end
