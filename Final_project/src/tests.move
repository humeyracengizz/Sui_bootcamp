
module AssetManagerTest {
    use 0x1::Sui::TxContext;
    use 0x1::AssetManager;

    #[test]
    fun test_asset_manager() {
        let alice = 0xAlice;
        let bob = 0xBob;

        let ctx_alice = TxContext{sender: alice};
        let ctx_bob = TxContext{sender: bob};

        AssetManager::init();


        let asset_id = AssetManager::createAsset(100);

        let result_fail = move(
            || AssetManager::transferAsset(asset_id, bob)
        );

        let new_asset_id = AssetManager::createAsset(50);

        AssetManager::transferAsset(new_asset_id, alice);

        let event = 0x1::AssetManager::AssetTransferEvent::fetch_latest();
        assert_eq!(event.asset_id, new_asset_id);
        assert_eq!(event.from, bob);
        assert_eq!(event.to, alice);
        assert_eq!(event.value, 50);
    }
};
