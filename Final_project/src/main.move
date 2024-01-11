
module AssetManager {
    use 0x1::Sui::Vector;


    struct Asset has key {
        id: UID,
        owner: address,
        value: u64,
    }

 
    event AssetTransferEvent(asset_id: UID, from: address, to: address, value: u64);


    public fun init() {

    }

    public fun createAsset(value: u64): UID {
        let asset_id = 0x1::AssetManager::Asset::create(Asset{
            id: object::new(),
            owner: move_from(tx_context::sender()),
            value,
        });

        asset_id
    }

    public fun transferAsset(asset_id: UID, to: address) {
        let asset = 0x1::AssetManager::Asset::borrow_global(asset_id).unwrap();
        assert(asset.owner == tx_context::sender(), 101, 0);
    
        0x1::AssetManager::Asset::mutate(asset_id, |a| a.owner = to);

        0x1::AssetManager::AssetTransferEvent(asset_id, tx_context::sender(), to, asset.value);
    }
}