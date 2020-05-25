// it's developed by Azozz ALFiras


#import <substrate.h>


// 1- need add the bundle library on file centet
// 2- like it  Depends: mobilesubstrate, co.azozzalfiras.azflibrary
// this my library
// https://repo.packix.com/package/co.azozzalfiras.azflibrary/
// if you have crash for app or bundle tweak need add this on Makefile
// $(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value


// like it using
%hook AzozzALFiras
-(void)Status{


// this for get udid && device for azflibrary
NSURL *urlDeive = [NSURL URLWithString:[@"http://127.0.0.1:1357/" stringByAppendingPathComponent:@"device"]];
NSMutableURLRequest *requestDevice = [NSMutableURLRequest requestWithURL:urlDeive cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
[requestDevice setHTTPMethod:@"GET"];
NSData *receivedDataDevice = [NSURLConnection sendSynchronousRequest:requestDevice returningResponse:nil error:nil]?:[NSData data];
NSDictionary *jsonRespDevice = [NSJSONSerialization JSONObjectWithData:receivedDataDevice options:0 error:nil]?:@{};
NSString* udid = jsonRespDevice[@"udid"];
NSString* device = jsonRespDevice[@"device"];


if(udid && device){


// This information should be changed according to the information in your tweak
NSString *URLPackix = @"https://repo.packix.com/api/drm/check";
NSString *identifier = @"com.example.tweak";
NSString *token = @"640f0b36-688d-481a-b03a-9886cc59323a";
NSString *FinishedURL = [NSString stringWithFormat:@"%@?udid=%@&model=%@&identifier=%@&token=%@", URLPackix, udid, device, identifier, token];


NSURL *URLRequest = [NSURL URLWithString:FinishedURL];
NSMutableURLRequest *RequestPackix = [NSMutableURLRequest requestWithURL:URLRequest cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
[RequestPackix setHTTPMethod:@"POST"];
NSData *receivedDataDevice = [NSURLConnection sendSynchronousRequest:RequestPackix returningResponse:nil error:nil]?:[NSData data];
NSDictionary *PackixStatus = [NSJSONSerialization JSONObjectWithData:receivedDataDevice options:0 error:nil]?:@{};

NSString* status = [PackixStatus objectForKey:@"status"];

if([status isEqualToString:@"completed"]) {
// Device is authorized to use this package
}
else if ([status isEqualToString:@"failed"]) {
// Device is not authorized to use this package
}
else {
// An error occurred
}


} else {
// Device doesn't download azflibrary

}

}
%end
