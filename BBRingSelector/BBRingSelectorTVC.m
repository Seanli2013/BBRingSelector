//
//  BBRingSelectorTVC.m
//  BBRingSelector
//
//  Created by 大钟威武 on 14-1-20.
//  Copyright (c) 2014年 bigbelldev.com. All rights reserved.
//


#import "BBRingSelectorTVC.h"
#import "AudioConfigData.h"
#import <AudioToolbox/AudioServices.h>

@interface BBRingSelectorTVC ()

@end

@implementation BBRingSelectorTVC
SystemSoundID _soundId;
#define kAudioSelected @"AudioSelected"
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    AudioServicesDisposeSystemSoundID(_soundId);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // 记录下用户的选择
    [[NSUserDefaults standardUserDefaults] setObject:cell.textLabel.text forKey:kAudioSelected];
    
    [tableView reloadData];
    NSString *pathForResource = [AudioConfigData getPathForResourceUsingKey:cell.textLabel.text];
    if ([pathForResource length] > 0) {
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:pathForResource ofType:@"caf"];
        //        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &soundID);
        // 先停止正在播放的音轨
        AudioServicesDisposeSystemSoundID(_soundId);
        // 新建一个soundId
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &_soundId);
        // 播放新的soundId
        AudioServicesPlaySystemSound (_soundId);
        
    }
    else
    {
        // 不该到这里
        NSLog(@"Something Panic Happens!");
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? [[[AudioConfigData shortAudioConfigListDict] allKeys] count] :[[[AudioConfigData longAudioConfigListDict] allKeys] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? [AudioConfigData getSectionName:1] : [AudioConfigData getSectionName:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AudioSelectionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = [[AudioConfigData longAudioConfigListDict] allKeys][indexPath.row];
        cell.detailTextLabel.text = [AudioConfigData getSecondsFromAudioName:[[AudioConfigData longAudioConfigListDict] objectForKey:cell.textLabel.text]];
    }
    else
    {
        cell.textLabel.text = [[AudioConfigData shortAudioConfigListDict] allKeys][indexPath.row];
        cell.detailTextLabel.text = [AudioConfigData getSecondsFromAudioName:[[AudioConfigData shortAudioConfigListDict] objectForKey:cell.textLabel.text]];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kAudioSelected] isEqualToString:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
