//
//  ClientDefine.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#ifndef ClientDefine_h
#define ClientDefine_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


/**
 *define:iOS 7.0的版本判断
 */
#define iOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] != NSOrderedAscending)

/**
 *define:iOS 8.0的版本判断
 */
#define iOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)

/**
 *define:iOS 9.0的版本判断
 */
#define iOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"9" options:NSNumericSearch] != NSOrderedAscending)

/**
 *define:iOS 10.0的版本判断
 */
#define iOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"10" options:NSNumericSearch] != NSOrderedAscending)

/**
 *define:iOS 11.0的版本判断
 */
#define iOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"11" options:NSNumericSearch] != NSOrderedAscending)

/**
 *define:iOS 12.0的版本判断
 */
#define iOS12_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"12" options:NSNumericSearch] != NSOrderedAscending)

/**
 *define:屏幕的宽高比
 */
#define CURRENT_SIZE(_size) _size / 375.0 * SCREEN_WIDTH

/**
 *  设备判断...
 */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_Pad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !is_Pad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !is_Pad : NO)

//判断iPhoneX所有系列
#define ISIPhoneXSeries (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)
#define StatusBar_H (ISIPhoneXSeries ? 44.0 : 20.0)
#define NavBar_H         44
#define TabBar_H  (ISIPhoneXSeries ? 83.0 : 49.0)

#define LInteger(_ref) [NSString stringWithFormat:@"%ld",(long)_ref]
#define L(_ref) [NSString stringWithFormat:@"%@",_ref]
#define FORMAT(f, ...)      [NSString stringWithFormat:f, ## __VA_ARGS__]

#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqualToString:@"(null)"]) || ([(_ref) isEqualToString:@"(Null)"]) || ([(_ref) isEqualToString:@"(NULL)"]) || ([(_ref) isEqualToString:@"(null)"]) || ([(_ref) isEqualToString:@"<null>"]) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqualToString:@""]) || ([(_ref) length] == 0))

#endif /* ClientDefine_h */
