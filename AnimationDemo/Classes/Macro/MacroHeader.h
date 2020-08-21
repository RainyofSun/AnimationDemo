//
//  MacroHeader.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#ifndef MacroHeader_h
#define MacroHeader_h

#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
#define SizeWidth(W)   (W*(ScreenWidth)/375)
#define SizeHeight(H)  (H*(ScreenHeight)/667)

/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(IPHONEXAbove?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(IPHONEXAbove?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(IPHONEXAbove?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(IPHONEXAbove?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(IPHONEXAbove?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(IPHONEXAbove?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

#define KeyWindow   [[[UIApplication sharedApplication] delegate] window]

// 颜色
#define RGB(R,G,B)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:1.0]
#define RGBA(R,G,B,A)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:A]
#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]   //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000
#define HexAColor(hexValue,a)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:a]

/// 弱类型
#define WEAK_DEFINE(Obj)    __weak typeof(Obj) weak_##Obj = Obj
#define WEAK(Obj)           weak_##Obj
#define wself               weak_self

/// Block类型
#define BLOCK_DEFINE(Obj)   __block typeof(Obj) block_##Obj = Obj
#define BLOCK(Obj)          block_##Obj

/// 字体
// 翩翩体
#define PianPianFontSize(fontSize) [UIFont fontWithName:@"PingFang HK" size:fontSize]
// 娃娃体
#define WaWaFontSize(fontSize)     [UIFont fontWithName:@"Heiti SC" size:fontSize]

#endif /* MacroHeader_h */
