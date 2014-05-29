//
//  DESEncry.m
//  TextProject
//
//  Created by sanwangkeji on 13-3-5.
//  Copyright (c) 2013年 sanwangkeji. All rights reserved.
//


#import "MICDESEncry.h"
#import <CommonCrypto/CommonCryptor.h>


@implementation NSData(MyMethods)

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

- (NSString *)base64Encoding;
{
    if (self.length == 0)
        return @"";
    
    char *characters = malloc(self.length*3/2);
    
    if (characters == NULL)
        return @"";
    
    int end = self.length - 3;
    int index = 0;
    int charCount = 0;
    int n = 0;
    
    while (index <= end) {
        int d = (((int)(((char *)[self bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[self bytes])[index + 1]) & 0x0ff) << 8)
        | ((int)(((char *)[self bytes])[index + 2]) & 0x0ff);
        
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = encodingTable[d & 63];
        
        index += 3;
        
        if(n++ >= 14)
        {
            n = 0;
            characters[charCount++] = ' ';
        }
    }
    if(index == self.length - 2)
    {
        int d = (((int)(((char *)[self bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[self bytes])[index + 1]) & 255) << 8);
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = '=';
    }
    else if(index == self.length - 1)
    {
        int d = ((int)(((char *)[self bytes])[index]) & 0x0ff) << 16;
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = '=';
        characters[charCount++] = '=';
    }
    NSString * rtnStr =
    MIC_AUTORELEASE([[NSString alloc] initWithBytesNoCopy:characters
                                                   length:charCount
                                                 encoding:NSUTF8StringEncoding
                                             freeWhenDone:YES]);
    return rtnStr;
}
@end


@implementation MICDESEncry

//DES加密
+(NSString *)encryptWithDES:(NSString *)plainText Key:(NSString *)strKey Iv:(NSString*)strIv
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    const char* iv=[strIv UTF8String];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [strKey UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64Encoding];
//        NSLog(@"加密： %@",ciphertext);
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
//        ciphertext=[ciphertext stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
//        ciphertext = [DESEncry URLEscaped:ciphertext];
    }
    return ciphertext;
}
//URL转义
+(NSString *)URLEscaped:(NSString *)str
{
//    CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)str, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                                  kCFStringEncodingUTF8);
//    
//    NSString *outStr = [NSString stringWithString:(NSString *)escaped];
//    CFRelease(escaped);
//    return [[outStr copy] autorelease];
    return [self EscapingForURLQuery:str];
}

#pragma mark - URL Escaping and Unescaping

+ (NSString *)EscapingForURLQuery :(NSString*)str {
	NSString *result = str;
    
	static CFStringRef leaveAlone = CFSTR(" ");
	static CFStringRef toEscape = CFSTR("\n\r:/=,!$&'()*+;[]@#?%");
    
	CFStringRef escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, leaveAlone,
																	 toEscape, kCFStringEncodingUTF8);
    
	if (escapedStr) {
		NSMutableString *mutable = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
		CFRelease(escapedStr);
        
		[mutable replaceOccurrencesOfString:@" " withString:@"+" options:0 range:NSMakeRange(0, [mutable length])];
		result = mutable;
	}
	return result;
}


+ (NSString *)UnescapingFromURLQuery :(NSString*)str {
	NSString *deplussed = [str stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
