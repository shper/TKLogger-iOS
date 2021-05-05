//
//  TKLogger-Objc.h
//  Pods
//
//  Created by Shper on 2021/5/5.
//

#ifndef TKLogger_Objc_h
#define TKLogger_Objc_h

#define TKLoggerVerbose(msg)  [TKLogger verbose:msg :@"" :[NSString stringWithUTF8String:__FILE__] :NSStringFromSelector(_cmd) :__LINE__];
#define TKLoggerDebug(msg)  [TKLogger debug:msg :@"" :[NSString stringWithUTF8String:__FILE__] :NSStringFromSelector(_cmd) :__LINE__];
#define TKLoggerInfo(msg)  [TKLogger info:msg :@"" :[NSString stringWithUTF8String:__FILE__] :NSStringFromSelector(_cmd) :__LINE__];
#define TKLoggerWarning(msg)  [TKLogger warning:msg :@"" :[NSString stringWithUTF8String:__FILE__] :NSStringFromSelector(_cmd) :__LINE__];
#define TKLoggerError(msg)  [TKLogger error:msg :@"" :[NSString stringWithUTF8String:__FILE__] :NSStringFromSelector(_cmd) :__LINE__];

#endif /* TKLogger_Objc_h */
