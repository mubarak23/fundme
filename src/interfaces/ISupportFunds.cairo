
use core::starknet::ContractAddress;

#[starknet::interface]
pub trait ISupportFund<TContractState> {
    // EXTERNAL FUNCTIONS
    fn set_reason(ref self: TContractState, reason: ByteArray);
    fn set_goal(ref self: TContractState, goal: u256);
    fn set_name(ref self: TContractState, name: ByteArray);
    fn add_receive_donation(ref self: TContractState, strks: u256);
    fn withdraw(ref self: TContractState);
    fn set_contact_handle(ref self: TContractState, contact_handle: ByteArray);
    fn set_type(ref self: TContractState, fund_type: u8);

    // GETTER FUNCTIONS
    fn get_id(self: @TContractState) -> u128;
    fn get_owner(self: @TContractState) -> ContractAddress;
    fn is_owner(self: @TContractState, current_caller: ContractAddress) -> bool;
    fn get_name(self: @TContractState) -> ByteArray;
    fn get_reason(self: @TContractState) -> ByteArray;
    fn get_goal(self: @TContractState) -> u256;
    fn get_contact_handle(self: @TContractState) -> ByteArray;
    fn get_type(self: @TContractState) -> u8;
}
