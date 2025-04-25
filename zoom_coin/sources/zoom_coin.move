module zoom_coin::coin {




    public struct ZoomCoin has key, store{
        id: UID,
        balance: u64,
        creator: address,
    }

    public fun mint(creator: address, amount: u64, ctx: &mut TxContext): ZoomCoin {
        let uid = object::new(ctx);
        ZoomCoin {
            id: uid,
            balance: amount,
            creator,
        }
    }
    public fun destroy(coin: ZoomCoin) {
        assert!(coin.balance == 0, 0);
        let ZoomCoin { id, balance: _, creator: _ } = coin;
        object::delete(id);
    }




    #[test]
    public fun test_mint_sets_value_and_creator() {
        let creator: address = @0x123;
        let mut ctx = tx_context::new(creator, x"0000000000000000000000000000000000000000000000000000000000000000"
, 0, 0, 0);
        let mut zoom = zoom_coin::coin::mint(@0x123, 1000, &mut ctx);

        assert!(zoom.balance == 1000);
        assert!(zoom.creator == creator, 101);
        zoom.balance = 0;
        zoom_coin::coin::destroy(zoom);
    }
}