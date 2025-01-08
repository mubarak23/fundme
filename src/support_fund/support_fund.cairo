
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
    use fundme::interfaces::ISupportFund::ISupportFund;
      use fundme::base::errors::Errors::{
        ZERO_ADDRESS_CALLER, NOT_OWNER, INSUFFICIENT_ALLOWANCE, USER_HAS_NOT_VOTED, WRONG_OWNER_ACTION, FUNDING_GOAL_REACH, USER_VOTED, OWNER_ACTION
    };
    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};

    // CONSTANTS
   //  const STRK_TOKEN_ADDRESS: ByteArray = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";
     // ***************************************************************************************
    //                            STORAGE
    // ***************************************************************************************
    #[storage]
    struct Storage {
        id: u256,
        owner: ContractAddress,
        name: ByteArray,
        reason: ByteArray,
        goal_amount: u256,
        state: u256,
        contact_handler: ByteArray,
        fund_type: u256,
        support_fund_voters: Map::<ContractAddress, u64>,
        support_fund_votes: u256,
        strk_token: ContractAddress,
    }

    // *************************************************************************
    //                            CONSTRUCTOR
    // *************************************************************************
    #[constructor]
    fn constructor(
         ref self: ContractState,
         id: u256,
         owner: ContractAddress,
         name: ByteArray,
         reason: ByteArray,
         goal: u256,
         state: u256,
         contact_handler: ByteArray,
         fund_type: u256,
         strk_token: ContractAddress,
    ){
        self.id.write(id);
        self.owner.write(owner);
        self.name.write(name);
        self.reason.write(reason);
        self.goal_amount.write(goal);
        self.state.write(state);
        self.contact_handler.write(contact_handler);
        self.fund_type.write(fund_type);
        self.strk_token.write(strk_token);
    }
     // *************************************************************************
    //                            EXTERNALS
    // *************************************************************************
      #[abi(embed_v0)]
      impl SupportFundImpl of ISupportFund<ContractState> {
        // only owner can set support fund name
         fn set_name(ref self: ContractState, name: ByteArray){
            let caller = get_caller_address();
            assert(self.owner.read() == caller, WRONG_OWNER_ACTION);
            self.name.write(name);
         }
           fn set_goal(ref self: ContractState, goal_amount: u256){
              let caller = get_caller_address();
              assert(self.owner.read() != caller, WRONG_OWNER_ACTION);
              self.goal_amount.write(goal_amount)
           }
          fn set_reason(ref self: ContractState, reason: ByteArray){
              let caller = get_caller_address();
              assert(self.owner.read() == caller, WRONG_OWNER_ACTION);
              self.reason.write(reason)
          } 
          fn set_type(ref self: ContractState, fund_type: u256) {
            let caller = get_caller_address();
            assert(self.owner.read() == caller, WRONG_OWNER_ACTION);
            self.fund_type.write(fund_type);
          }
           fn set_contact_handler(ref self: ContractState, contact_handler: ByteArray) {
             let caller = get_caller_address();
             assert(self.owner.read() == caller, WRONG_OWNER_ACTION);
             self.contact_handler.write(contact_handler);
           }
         fn up_vote(ref self: ContractState) {
            let caller = get_caller_address();
            let caller_vote = self.support_fund_voters.read(caller);
            assert(caller_vote== 0, USER_VOTED);
            self.support_fund_voters.write(caller, 1);
            self.support_fund_votes.write(self.support_fund_votes.read() + 1);
            // EMIT EVENT HERE
          }
        fn down_vote(ref self: ContractState) {
            let caller = get_caller_address();
            let caller_vote = self.support_fund_voters.read(caller);
            assert(caller_vote == 1, USER_HAS_NOT_VOTED);
            self.support_fund_voters.write(caller, 0);
            self.support_fund_votes.write(self.support_fund_votes.read() - 1);
            // EMIT EVENT HERE
        }  
         fn add_receive_donation(ref self: ContractState, amount: u256) {
           
            let current_balance = self.get_current_goal_state();
            let goal_amount = self.goal_amount.read();
            assert(current_balance >= goal_amount, FUNDING_GOAL_REACH);
            // if user give allowance for the contract to spend that amount
            assert(
                self.token_dispatcher()
                    .allowance(get_caller_address(), get_contract_address()) >= amount,
                INSUFFICIENT_ALLOWANCE,
            );
            // change the user
            self.token_dispatcher().transfer_from(get_caller_address(), get_contract_address(), amount);
            
         }

         // GETTERS
         fn get_current_goal_state(self: @ContractState) -> u256 {
            self.token_dispatcher().balance_of(get_contract_address())
         }
      }

    // *************************************************************************
    //                            INTERNALS
    // *************************************************************************
    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn token_dispatcher(self: @ContractState) -> IERC20Dispatcher {
            IERC20Dispatcher {
                contract_address: self.strk_token.read()
            }
        }
    }
}