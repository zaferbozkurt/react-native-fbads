declare const _default: {
    /**
     * Load interstitial ad for a given placementId and shows it
     */
    showAd(placementId: string): Promise<boolean>;
    /**
     * Preloads an interstitial ad for a given placementId
     */
    preloadAd(placementId: string): Promise<boolean>;
    /**
     * Shows an already preloaded Ad
     */
    showPreloadedAd(placementId: string): Promise<boolean>;
};
export default _default;
