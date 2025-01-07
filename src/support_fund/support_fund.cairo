
use starknet::ContractAddress;

#[starknet::contract]
pub mod SupportFund {
    // ***************************************************************************************
    //                            IMPORT
    // ***************************************************************************************
    use core::array::ArrayTrait;
    use core::traits::TryInto;
    use core::starknet::{
        ContractAddress, get_caller_address, syscalls::deploy_syscall, ClassHash,
        get_block_timestamp,
        contract_address_const,
        get_contract_address,
        storage::{Map, StorageMapReadAccess, StorageMapWriteAccess, StoragePathEntry}
    };

     // ***************************************************************************************
    //                            STORAGE
    // ***************************************************************************************
    #[storage]
    struct Storage {
        id: u128,
        owner: ContractAddress,
        name: ByteArray,
        reason: ByteArray,
        goal: u256,
        state: u8,
        contact_handle: ByteArray,
        fund_type: u8,
    }
}