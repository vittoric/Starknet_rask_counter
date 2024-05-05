#[starknet::interface]
 trait ICounter<T> {
    // Increases by 1
    fn increase_counter(ref self: T);
    // Decreases the counter value by 1
    fn decrease_counter(ref self: T);
    // Get counter
    fn get_counter(self: @T) -> u128;
}

#[starknet::contract]
pub mod Counter {
    #[storage]
    struct Storage {
        // Counter variable
        counter: u128,
    }

    #[constructor]
    fn constructor(ref self: ContractState, init_value: u128) {
        // Store initial value
        self.counter.write(init_value);
    }

    #[abi(embed_v0)]
    impl Counter of super::ICounter<ContractState> {
        fn get_counter(self: @ContractState) -> u128 {
            return self.counter.read();
        }
        fn increase_counter(ref self: ContractState) {
            // Store counter value + 1
            let counter = self.counter.read() + 1;
            self.counter.write(counter);
        }
        fn decrease_counter(ref self: ContractState) {
            // Store counter value - 1
            let counter = self.counter.read() - 1;
            self.counter.write(counter);
        }
    }
}


