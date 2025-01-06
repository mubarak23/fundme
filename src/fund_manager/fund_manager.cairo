
use starknet::ContractAddress;

#[starknet::contract]
pub mod FundManager {
    // ***************************************************************************************
    //                            IMPORT
    // ***************************************************************************************
    use core::array::ArrayTrait;
    use core::traits::TryInto;
    use core::starknet::{
        ContractAddress, get_caller_address, syscalls::deploy_syscall, ClassHash,
        get_block_timestamp,
        storage::{Map, StorageMapReadAccess, StorageMapWriteAccess, StoragePathEntry}
    };

     // ***************************************************************************************
    //                            STORAGE
    // ***************************************************************************************
    #[storage]
    struct Storage {
        support_funds_counts: u256,
        owner: ContractAddress,
        support_funds: Map<u256, ContractAddress>,
        support_fund_class: ClassHash
    }
}