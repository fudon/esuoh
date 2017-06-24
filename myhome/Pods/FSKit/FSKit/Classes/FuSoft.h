//
//  FuSoft.h
//  Pods
//
//  Created by fudon on 2017/6/17.
//
//

#ifndef FuSoft_h
#define FuSoft_h

#ifdef DEBUG
//# define FSLog(format, ...) NSLog((@"\nFSLog:%s" "%s" "- %d\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
# define FSLog(format, ...) NSLog((@"%s" "- %d\n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define FSLog(...);
#endif

/******************__system__*********************/
#define MININ(A,B)      ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })
#define WEAKSELF(A)      __weak typeof(*&self)A = self

#define HEIGHTFC            ([UIScreen mainScreen].bounds.size.height)
#define WIDTHFC             ([UIScreen mainScreen].bounds.size.width)
#define IOSGE(A)            (([[UIDevice currentDevice].systemVersion floatValue] >= A)?YES:NO)
#define IPAD                ([[[UIDevice currentDevice].model componentsSeparatedByString:@" "][0] isEqualToString:@"iPad"]?YES:NO)
#define isIPAD              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIPHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IPHONE              ([[[UIDevice currentDevice].model componentsSeparatedByString:@" "][0] isEqualToString:@"iPhone"]?YES:NO)

#define RGBCOLOR(R, G, B, A)        ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A])
#define RGB16(rgbValue)             [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define WECHAT_GREEN        RGBCOLOR(61, 186, 67, 1)

#define IMAGENAMED(A)               [UIImage imageNamed:A]
#define ROUNDIMAGE(A,B)             ([FSKit circleImage:IMAGENAMED(A) withParam:B]) // B default is 0.
#define FONTFC(A)                   ([UIFont systemFontOfSize:A])
#define FONTBOLD(A)                 ([UIFont fontWithName:@"Helvetica-Bold" size:A])
#define FONTOBLIQUE(A)              ([UIFont fontWithName:@"Helvetica-BoldOblique" size:A])
#define FONTLIQUE(A)                ([UIFont fontWithName:@"Helvetica-Oblique" size:A])

#define FLSTRING(A)                 ([FSKit bankStyleData:A])
#define FLSTRINGTHR(A)              ([FSKit bankStyleDataThree:A])
#define FLSTRINGBACK(A)             ([FSKit backBankData:A])
#define FLSTRAB(A,B)                (STRFC(A,FLSTRING(B)))
#define FLSTRBA(A,B)                (STRFC(FLSTRING(A),B))
#define FLZERONONE(A)               ([FSKit zeroHandle:A])
#define FSPLACEHOLDER(A)            ([FSKit placeholderStringFor:A])
#define FSPLACEHOLDERBY(A,B)        ([FSKit placeholderStringFor:A with:B])
#define FABSVALUE(A)                ([FSKit absoluteValue:A])

#define FSValidateString(A)         [FSKit isValidateString:A]
#define FSValidateArray(A)          [FSKit isValidateArray:A]
#define FSValidateDictionary(A)     [FSKit isValidateDictionary:A]

/******************__tag__**********************/
#define   TAGVIEW               1000
#define   TAGBUTTON             1100
#define   TAGTABLEVIEW          1200
#define   TAGSCROLLVIEW         1300
#define   TAGLABEL              1400
#define   TAGIMAGEVIEW          1500
#define   TAGSWITCH             1600
#define   TAGSLIDER             1700
#define   TAGSEGMENT            1800
#define   TAGWEBVIEW            1900
#define   TAGMAPVIEW            2000
#define   TAGTEXTFIELD          2100
#define   TAGTEXTVIEW           2200
#define   TAGPROGRESSVIEW       2300
#define   TAGALERT              2400
#define   TAGPICKERVIEW         2500
#define   TAGTEMPONE            2600
#define   TAGTEMPTWO            2700
#define   TAGTEMPTHE            2800
#define   TAGCELL               2900
#define   TAGBASEVIEW           3000


#endif /* FuSoft_h */
