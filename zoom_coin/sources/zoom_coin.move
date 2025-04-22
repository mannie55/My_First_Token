module zoom_coin::zoom_coin {


    public struct ZoomCoin has key, store {
        id: UID,
        balance: u64,
    }

    public fun mint(creator: &signer, amount: u64, ctx: &mut TxContext): ZoomCoin {
        let uid = object::new(ctx);
        ZoomCoin {
            id: uid,
            balance: amount
        }
    }
}