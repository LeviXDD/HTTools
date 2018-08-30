//
//  CommonFrameDefine.h
//  caomall
//
//  Created by 谭康 on 2018/5/11.
//  Copyright © 2018年 Levi. All rights reserved.
//

#ifndef CommonFrameDefine_h
#define CommonFrameDefine_h

#define SCREEN_HEIGHT                   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH                    [[UIScreen mainScreen] bounds].size.width
#define NAVIBAR_STATUSBAR_HEIGHT 44 + [[UIApplication sharedApplication] statusBarFrame].size.height
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIBAR_HEIGHT 44
//line
#define BOLD_LINE_WIDTH 1.0f
#define LINE_COLOR [UIColor hx_colorWithHexString:@"#E6E6E6"]
#define THIN_LINE_WIDTH 0.5f

#endif /* CommonFrameDefine_h */
