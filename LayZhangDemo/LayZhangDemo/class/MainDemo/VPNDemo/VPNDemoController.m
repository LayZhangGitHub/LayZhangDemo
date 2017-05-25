//
//  VPNDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "VPNDemoController.h"
#import <NetworkExtension/NetworkExtension.h>

@interface VPNDemoController ()

@property (nonatomic, strong) NEVPNManager *vpnManager;

@end

@implementation VPNDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"VPNDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self vpnDemo];
//        [self httpDemo];
}

- (void)vpnDemo {
    // init VPN manager
    self.vpnManager = [NEVPNManager sharedManager];
    // load config from perference
    [_vpnManager loadFromPreferencesWithCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Load config failed [%@]", error.localizedDescription);
            return;
        }
        NEVPNProtocolIPSec *p = _vpnManager.protocol;
        if (p) {
            // Protocol exists.
            // If you don't want to edit it, just return here.
        } else {
            // create a new one.
            p = [[NEVPNProtocolIPSec alloc] init];
        }
        // config IPSec protocol
        p.username = @"zhanglei";
        p.serverAddress = @"60.191.4.206";;
        // Get password persistent reference from keychain
        // If password doesn't exist in keychain, should create it beforehand.
        // [self createKeychainValue:@"your_password" forIdentifier:@"VPN_PASSWORD"];
        p.passwordReference = [self searchKeychainCopyMatching:@"WNFHcBfx27UQVIZm"];
        // PSK
        p.authenticationMethod = NEVPNIKEAuthenticationMethodSharedSecret;
        // [self createKeychainValue:@"your_psk" forIdentifier:@"PSK"];
        p.sharedSecretReference = [self searchKeychainCopyMatching:@"PSK"];
        /*
         // certificate
         p.identityData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];
         p.identityDataPassword = @"[Your certificate import password]";
         */
        p.localIdentifier = @"[VPN local identifier]";
        p.remoteIdentifier = @"[VPN remote identifier]";
        p.useExtendedAuthentication = YES;
        p.disconnectOnSleep = NO;
        _vpnManager.protocol = p;
        _vpnManager.localizedDescription = @"IPSec Demo description";
        [_vpnManager saveToPreferencesWithCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"Save config failed [%@]", error.localizedDescription);
            }
        }];
    }];
}
- (IBAction)startVPNConnection:(id)sender {
    //[[VodManager sharedManager] installVPNProfile];
    NSError *startError;
    [_vpnManager.connection startVPNTunnelAndReturnError:&startError];
    if (startError) {
        NSLog(@"Start VPN failed: [%@]", startError.localizedDescription);
    }
}
#pragma mark - KeyChain
static NSString * const serviceName = @"im.zorro.ipsec_demo.vpn_config";
- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    return searchDictionary;
}
- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    // Add search return types
    // Must be persistent ref !!!!
    [searchDictionary setObject:@YES forKey:(__bridge id)kSecReturnPersistentRef];
    CFTypeRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, &result);
    return (__bridge_transfer NSData *)result;
}
- (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dictionary);
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (void)httpDemo {
    //    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    //    [options setObject:@"" forKey:kNEHotspotHelperOptionDisplayName];
    //
    //     dispatch_queue_t queue = dispatch_queue_create("com.myapp.ex", NULL);
    //     BOOL returnType = [NEHotspotHelper registerWithOptions:options queue:queue handler: ^(NEHotspotHelperCommand * cmd) {
    //        NEHotspotNetwork* network;
    //        NSLog(@"COMMAND TYPE:   %ld", (long)cmd.commandType);
    //        [cmd createResponse:kNEHotspotHelperResultAuthenticationRequired];
    //        if (cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType ==kNEHotspotHelperCommandTypeFilterScanList) {
    //            NSLog(@"WIFILIST:   %@", cmd.networkList);
    //
    //            for (network  in cmd.networkList) {
    //
    //                NSLog(@"COMMAND TYPE After:   %ld", (long)cmd.commandType);
    //
    //                if ([network.SSID isEqualToString:@"ssid"]|| [network.SSID isEqualToString:@"WISPr Hotspot"]) {
    //
    //                    double signalStrength = network.signalStrength;
    //                    NSLog(@"Signal Strength: %f", signalStrength);
    //                    [network setConfidence:kNEHotspotHelperConfidenceHigh];
    //                    [network setPassword:@"password"];
    //
    //                    NEHotspotHelperResponse *response = [cmd createResponse:kNEHotspotHelperResultSuccess];
    //                    NSLog(@"Response CMD %@", response);
    //
    //                    [response setNetworkList:@[network]];
    //                    [response setNetwork:network];
    //                    [response deliver];
    //                }
    //            }
    //        }
    //
    //    }];
    //
    //     NSLog(@"result :%d", returnType);
    //
    //     NSArray *array = [NEHotspotHelper supportedNetworkInterfaces];
    //
    //     NSLog(@"wifiArray:%@", array);
    //
    //     NEHotspotNetwork *connectedNetwork = [array lastObject];
    //
    //     NSLog(@"supported Network Interface: %@", connectedNetwork);
    
    NSLog(@"in wifi scan");
        NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    //    NSMutableDictionary* infos = [[NSMutableDictionary alloc] init];
        [options setObject:@"meme" forKey:kNEHotspotHelperOptionDisplayName];
    
        dispatch_queue_t queue = dispatch_queue_create("LiyiZhan.WifiDemo", 0);
    
        BOOL returnType = [NEHotspotHelper registerWithOptions:options queue:queue handler:^(NEHotspotHelperCommand * cmd){
            NSLog(@"in block");
            [cmd createResponse:kNEHotspotHelperResultAuthenticationRequired];
            if(cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList){
    
                NSLog(@"bbbb = %lu",cmd.networkList.count);
                for(NEHotspotNetwork* network in cmd.networkList){
                    NSString* ssid = network.SSID;
                    NSString* bssid = network.BSSID;
                    BOOL secure = network.secure;
                    BOOL autoJoined = network.autoJoined;
                    double signalStrength = network.signalStrength;
    
                    NSLog(@"SSID:%@ # BSSID:%@ # SIGNAL:%f ",ssid,bssid,signalStrength);
                }
            }
        }];
    
    //    var matchDomains = [String]();
    //    matchDomains.append(".");
    //
    //    let newSettings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: self.protocolConfiguration.serverAddress!)
    //    newSettings.iPv4Settings = NEIPv4Settings(addresses: MyIP() as! String, subnetMasks: MySubnet() as! String])
    //    newSettings.proxySettings = NEProxySettings()
    //    newSettings.proxySettings?.httpEnabled = true
    //    newSettings.proxySettings?.httpServer =
    //    NEProxyServer(address: MyProxyIP(), port: MyProxyPort());
    //    newSettings.proxySettings?.matchDomains = matchDomains;
    
    //    NSString *matchDomains = @"";
    
    
    //    NEProxyServer *neps = [[NEProxyServer alloc] initWithAddress:@"127.0.0.1" port:1111];
    //    NEPacketTunnelNetworkSettings *settings = [[NEPacketTunnelNetworkSettings alloc] initWithTunnelRemoteAddress:@"127.0.0.1"];
    //    settings.IPv4Settings = [[NEIPv4Settings alloc] initWithAddresses:@[@"123.0.0.1"]
    //                                                          subnetMasks:@[@"mySubnet"]];
    //    settings.proxySettings = [[NEProxySettings alloc] init];
    //    settings.proxySettings.HTTPEnabled = true;
    //    settings.proxySettings.HTTPServer = neps;
    //    settings.proxySettings.matchDomains = @[@"www.baidu.com"];
    
    
//    
//    [self setTunnelNetworkSettings:settings completionHandler:^(NSError * _Nullable error) {
//        
//        if (error) {
//            
//            NSLog(@"setTunnelNetworkSettings error: %@", error);
//            
//        } else {
//            
//            //            NSError *err;
//            
//            //            pendingCompletionHandler(err);
//        }
//        
//    }];
//
    
//    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
//    [options setObject:@"Connect using my app" forKey:kNEHotspotHelperOptionDisplayName];
//    dispatch_queue_t queue = dispatch_queue_create("com.myapp.wifi", 0);
////    [NEHotspotHelper registerWithOptions:<#(nullable NSDictionary<NSString *,NSObject *> *)#> queue:<#(nonnull dispatch_queue_t)#> handler:<#^(NEHotspotHelperCommand * _Nonnull cmd)handler#>];
//    
//    [NEHotspotHelper registerWithOptions:options queue:queue handler: ^(NEHotspotHelperCommand * cmd) {
//        if(cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList){
//            for (NEHotspotNetwork *eachNetwork in cmd.networkList) {
//                // Get Informations of the network
//                NSLog(@"%@", eachNetwork.SSID);
//            }
//        }
//    }];
//    
//    NEHotspotNetwork
}

@end
