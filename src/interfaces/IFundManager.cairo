use core::starknet::{ContractAddress, ClassHash};

#[starknet::interface]
pub trait IFundManager<TContractState> {
    // EXTERNAL FUNCTIONS
    fn new_support_funds( ref self: TContractState,
        name: ByteArray,
        funding_goal_amount: u256,
        contact_handle: ByteArray,
        reason: ByteArray,
        fund_type: u8) -> ContractAddress;
    fn get_support_clash_hash(self: @TContractState)-> ClassHash;
    fn get_owner(self: @TContractState) -> ContractAddress;
    fn get_support_fund_address(self: @TContractState) -> ContractAddress;

}