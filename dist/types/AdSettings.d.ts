declare type SDKLogLevel = 'none' | 'debug' | 'verbose' | 'warning' | 'error' | 'notification';
export declare type TrackingStatus = 'unavailable' | 'denied' | 'authorized' | 'restricted' | 'not-determined';
declare const _default: {
    /**
     * Contains hash of the device id
     */
    readonly currentDeviceHash: string;
    /**
     * Registers given device with `deviceHash` to receive test Facebook ads.
     */
    addTestDevice(deviceHash: string): void;
    /**
     * Clears previously set test devices
     */
    clearTestDevices(): void;
    /**
     * Sets current SDK log level
     */
    setLogLevel(logLevel: SDKLogLevel): void;
    /**
     * Specifies whether ads are treated as child-directed
     */
    setIsChildDirected(isDirected: boolean): void;
    /**
     * Sets mediation service name
     */
    setMediationService(mediationService: string): void;
    /**
     * Sets URL prefix
     */
    setUrlPrefix(urlPrefix: string): void;
    /**
     * Requests permission to track the user.
     *
     * Requires a [`NSUserTrackingUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription) in your `Info.plist`
     *
     * @platform iOS 14
     */
    requestTrackingPermission(): Promise<TrackingStatus>;
    /**
     * Gets the current tracking status.
     *
     * @platform iOS 14
     */
    getTrackingStatus(): Promise<TrackingStatus>;
    /**
     * Enable or disable the automatic Advertiser ID Collection. On iOS 14 it is recommended to only enable automatic Advertiser ID Collection when the user has granted permission to track. (@see `requestTrackingPermission()`)
     */
    setAdvertiserIDCollectionEnabled(enabled: boolean): void;
    /**
     * Enable or disable ads tracking. Only works for iOS 14+. In order to ask user for tracking permission (@see `requestTrackingPermission()`).
     */
    setAdvertiserTrackingEnabled(enabled: boolean): void;
};
export default _default;
