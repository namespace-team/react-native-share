//
//  LINEShare.m
//  RNShare
//
//  Created by Naresh Rawat on 26/09/2025.
//

#import "LINEShare.h"

@implementation LINEShare
RCT_EXPORT_MODULE();
- (void)shareSingle:(NSDictionary *)options reject:(RCTPromiseRejectBlock)reject resolve:(RCTPromiseResolveBlock)resolve {
    
    NSLog(@"Try LINE share");
    
    NSString *text = [[NSString alloc] initWithFormat:@"%@ %@", options[@"message"], options[@"url"]];
    NSString *escapedText = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"https://line.me/R/msg/text/?%@", escapedText];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *schemeURL = [NSURL URLWithString:url];
    
    
    if ([[UIApplication sharedApplication] canOpenURL:schemeURL]) {
        [[UIApplication sharedApplication] openURL:schemeURL options:@{} completionHandler:nil];
        
        resolve(@[@true, @""]);
    } else {
        // Cannot open Line
        NSString *contentLinkString = @"https://apps.apple.com/us/app/line/id443904275";
        NSURL *url = [NSURL URLWithString:contentLinkString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        
        NSString *errorMessage = @"Not installed";
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
        NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];
        
        NSLog(@"%@", errorMessage);
        reject(@"Not installed",@"Not installed",error);
    }
}

@end
