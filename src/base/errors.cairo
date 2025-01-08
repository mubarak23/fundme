pub mod Errors {
    pub const ZERO_ADDRESS_OWNER: felt252 = 'Owner cannot be zero addr';
    pub const ZERO_ADDRESS_CALLER: felt252 = 'Caller cannot be zero addr';
    pub const NOT_OWNER: felt252 = 'Caller Not Owner';
    pub const INSUFFICIENT_ALLOWANCE: felt252 = 'Insufficient Allowance';
    pub const USER_HAS_NOT_VOTED: felt252 = 'User Has Not Voted!';
    pub const WRONG_OWNER_ACTION: felt252 = 'Only Owner Action';
    pub const FUNDING_GOAL_REACH: felt252 = 'Funding Goal Reached';
    pub const USER_VOTED: felt252 = 'User already voted!';
    pub const OWNER_ACTION: felt252 = 'Only Owner Action';
}
