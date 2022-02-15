var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { NativeModules, Platform } from 'react-native';
const { CTKAdSettingsManager } = NativeModules;
export default {
    /**
     * Contains hash of the device id
     */
    get currentDeviceHash() {
        return CTKAdSettingsManager.currentDeviceHash;
    },
    /**
     * Registers given device with `deviceHash` to receive test Facebook ads.
     */
    addTestDevice(deviceHash) {
        CTKAdSettingsManager.addTestDevice(deviceHash);
    },
    /**
     * Clears previously set test devices
     */
    clearTestDevices() {
        CTKAdSettingsManager.clearTestDevices();
    },
    /**
     * Sets current SDK log level
     */
    setLogLevel(logLevel) {
        CTKAdSettingsManager.setLogLevel(logLevel);
    },
    /**
     * Specifies whether ads are treated as child-directed
     */
    setIsChildDirected(isDirected) {
        CTKAdSettingsManager.setIsChildDirected(isDirected);
    },
    /**
     * Sets mediation service name
     */
    setMediationService(mediationService) {
        CTKAdSettingsManager.setMediationService(mediationService);
    },
    /**
     * Sets URL prefix
     */
    setUrlPrefix(urlPrefix) {
        CTKAdSettingsManager.setUrlPrefix(urlPrefix);
    },
    /**
     * Requests permission to track the user.
     *
     * Requires a [`NSUserTrackingUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription) in your `Info.plist`
     *
     * @platform iOS 14
     */
    requestTrackingPermission() {
        return __awaiter(this, void 0, void 0, function* () {
            if (Platform.OS !== 'ios')
                return 'unavailable';
            return yield CTKAdSettingsManager.requestTrackingPermission();
        });
    },
    /**
     * Gets the current tracking status.
     *
     * @platform iOS 14
     */
    getTrackingStatus() {
        return __awaiter(this, void 0, void 0, function* () {
            if (Platform.OS !== 'ios')
                return 'unavailable';
            return yield CTKAdSettingsManager.getTrackingStatus();
        });
    },
    /**
     * Enable or disable the automatic Advertiser ID Collection. On iOS 14 it is recommended to only enable automatic Advertiser ID Collection when the user has granted permission to track. (@see `requestTrackingPermission()`)
     */
    setAdvertiserIDCollectionEnabled(enabled) {
        CTKAdSettingsManager.setAdvertiserIDCollectionEnabled(enabled);
    },
    /**
     * Enable or disable ads tracking. Only works for iOS 14+. In order to ask user for tracking permission (@see `requestTrackingPermission()`).
     */
    setAdvertiserTrackingEnabled(enabled) {
        if (Platform.OS !== 'ios') {
            return;
        }
        CTKAdSettingsManager.setAdvertiserTrackingEnabled(enabled);
    },
};
