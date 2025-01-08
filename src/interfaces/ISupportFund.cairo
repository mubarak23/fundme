use core::starknet::ContractAddress;

#[starknet::interface]
pub trait ISupportFund<TContractState> {
    // EXTERNAL FUNCTIONS
    fn set_reason(ref self: TContractState, reason: ByteArray);
    fn set_goal(ref self: TContractState, goal_amount: u256);
    fn set_name(ref self: TContractState, name: ByteArray);
    fn up_vote(ref self: TContractState);
    fn down_vote(ref self: TContractState);
    fn add_receive_donation(ref self: TContractState, amount: u256);
    fn withdraw(ref self: TContractState);
    fn set_contact_handler(ref self: TContractState, contact_handler: ByteArray);
    fn set_type(ref self: TContractState, fund_type: u256);

    // GETTER FUNCTIONS
    fn get_id(self: @TContractState) -> u256;
    fn get_owner(self: @TContractState) -> ContractAddress;
    fn is_owner(self: @TContractState) -> bool;
    fn get_name(self: @TContractState) -> ByteArray;
    fn get_reason(self: @TContractState) -> ByteArray;
    fn get_goal_amount(self: @TContractState) -> u256;
    fn get_contact_handler(self: @TContractState) -> ByteArray;
    fn get_type(self: @TContractState) -> u256;
    fn get_current_goal_state(self: @TContractState) -> u256;
}
