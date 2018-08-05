//
//  AcceptedFileUtils.m
//  OfficeManage
//
//  Created by Hsusue on 2018/8/5.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "AcceptedFileManager.h"

@implementation AcceptedFileManager


// 获取文件列表（降序）
- (NSArray *)getFileListInFolder {
    
    NSString *directory = [self getInboxPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 遍历目录
    // 获取目录下文件
    NSArray *paths = [fileManager subpathsAtPath:directory];
    // 对文件按照时间进行排序
    NSArray *sortedPaths = [paths sortedArrayUsingComparator:^(NSString * firstPath, NSString* secondPath) {//
        NSString *firstUrl = [directory stringByAppendingPathComponent:firstPath];//获取前一个文件完整路径
        NSString *secondUrl = [directory stringByAppendingPathComponent:secondPath];//获取后一个文件完整路径
        NSDictionary *firstFileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:firstUrl error:nil];//获取前一个文件信息
        NSDictionary *secondFileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:secondUrl error:nil];//获取后一个文件信息
        id firstData = [firstFileInfo objectForKey:NSFileModificationDate];//获取前一个文件修改时间
        id secondData = [secondFileInfo objectForKey:NSFileModificationDate];//获取后一个文件修改时间
        //        return [firstData compare:secondData];//升序
        return [secondData compare:firstData];//降序
    }];
    return sortedPaths;
}


// 获取文件全路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    // 拼接路径
    NSString *directoryPath = [self getInboxPath];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

// 删除文件
- (void)deleteFileWithName:(NSString*)fileName {
    // 获取全路路径
    NSString *filePath = [self getFileFullPathWithFileName:fileName];
    
    //删除文件
    BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    if (isSuccess) {
        NSLog(@"删除文件成功");
    }else{
        NSLog(@"删除文件失败");
    }
    
}


// 获取/Documents/Inbox路径
- (NSString *)getInboxPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"Inbox"];
}

@end
