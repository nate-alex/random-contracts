/**
 *Submitted for verification at Etherscan.io on 2020-02-23
*/

/**
 *Submitted for verification at Etherscan.io on 2020-01-19
*/

pragma solidity ^0.5.14;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     *
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either {approve} or {setApprovalForAll}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;
    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either {approve} or {setApprovalForAll}.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a {IERC721-safeTransferFrom}. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * IMPORTANT: It is unsafe to assume that an address for which this
     * function returns false is an externally-owned account (EOA) and not a
     * contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the {SafeMath}
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts may inherit from this and call {_registerInterface} to declare
 * their support of an interface.
 */
contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for ERC165 itself here
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual ERC165 interface is automatic and
     * registering its interface id is not required.
     *
     * See {IERC165-supportsInterface}.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is Context, ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][to] = approved;
        emit ApprovalForAll(_msgSender(), to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the _msgSender() to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransferFrom(from, to, tokenId, _data);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) internal {
        _transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _safeMint(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal {
        _mint(to, tokenId);
        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {_burn} instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "ERC721: burn of token that is not own");

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This function is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

/**
 * @title ERC-721 Non-Fungible Token with optional enumeration extension logic
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Enumerable is Context, ERC165, ERC721, IERC721Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Constructor function.
     */
    constructor () public {
        // register the supported interface to conform to ERC721Enumerable via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply(), "ERC721Enumerable: global index out of bounds");
        return _allTokens[index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        super._transferFrom(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);

        _addTokenToAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {ERC721-_burn} instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        _removeTokenFromOwnerEnumeration(owner, tokenId);
        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner) internal view returns (uint256[] storage) {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
    }
}

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract ERC721Metadata is Context, ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;
    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }


    /**
     * @dev Returns an URI for a given token ID.
     * Throws if the token ID does not exist. May return an empty string.
     * @param tokenId uint256 ID of the token to query
     */
     
/*
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
//        return _tokenURIs[tokenId];

        return string(abi.encodePacked("https://chainfacesrinkeby.azurewebsites.net/api/HttpTrigger?id=", id_to_value[tokenId]));
    }
*/

    /**
     * @dev Internal function to set the token URI for a given token.
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

/**
 * @title Full ERC721 Token
 * @dev This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology.
 *
 * See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
    constructor (string memory name, string memory symbol) public ERC721Metadata(name, symbol) {
        // solhint-disable-previous-line no-empty-blocks
    }
}

library Random
{
	/**
	* Initialize the pool with the entropy of the blockhashes of the blocks in the closed interval [earliestBlock, latestBlock]
	* The argument "seed" is optional and can be left zero in most cases.
	* This extra seed allows you to select a different sequence of random numbers for the same block range.
	*/
	function init(uint256 earliestBlock, uint256 latestBlock, uint256 seed) internal view returns (bytes32[] memory) {
		//require(block.number-1 >= latestBlock && latestBlock >= earliestBlock && earliestBlock >= block.number-256, "Random.init: invalid block interval");
		require(block.number-1 >= latestBlock && latestBlock >= earliestBlock, "Random.init: invalid block interval");
		bytes32[] memory pool = new bytes32[](latestBlock-earliestBlock+2);
		bytes32 salt = keccak256(abi.encodePacked(block.number,seed));
		for(uint256 i=0; i<=latestBlock-earliestBlock; i++) {
			// Add some salt to each blockhash so that we don't reuse those hash chains
			// when this function gets called again in another block.
			pool[i+1] = keccak256(abi.encodePacked(blockhash(earliestBlock+i),salt));
		}
		return pool;
	}
	
	/**
	* Initialize the pool from the latest "num" blocks.
	*/
	function initLatest(uint256 num, uint256 seed) internal view returns (bytes32[] memory) {
		return init(block.number-num, block.number-1, seed);
	}
	
	/**
	* Advances to the next 256-bit random number in the pool of hash chains.
	*/
	function next(bytes32[] memory pool) internal pure returns (uint256) {
		require(pool.length > 1, "Random.next: invalid pool");
		uint256 roundRobinIdx = uint256(pool[0]) % (pool.length-1) + 1;
		bytes32 hash = keccak256(abi.encodePacked(pool[roundRobinIdx]));
		pool[0] = bytes32(uint256(pool[0])+1);
		pool[roundRobinIdx] = hash;
		return uint256(hash);
	}
	
	/**
	* Produces random integer values, uniformly distributed on the closed interval [a, b]
	*/
	function uniform(bytes32[] memory pool, int256 a, int256 b) internal pure returns (int256) {
		require(a <= b, "Random.uniform: invalid interval");
		return int256(next(pool)%uint256(b-a+1))+a;
	}
}


contract morkV02 is ERC721Full {
    using SafeMath for uint256;

    mapping(string  => uint256) value_to_id;
    mapping(uint256 => string) id_to_value;

    mapping (uint256 => uint) internal idToGolfScore;
    mapping (uint256 => uint) internal idToPercentBear;
    mapping (uint256 => uint) internal idToFaceSymmetry;
    mapping (uint256 => uint) internal idToTextColor;
    mapping (uint256 => uint) internal idToBackgroundColor;
    

    constructor() ERC721Full("morkV0.2", "(◕-◕)") public {

        
    }

    
    function getLeftFace(uint256 seed) internal view returns (string memory leftFacePartID){

    bytes32[] memory pool = Random.initLatest(4, seed);        
        

		uint256 leftFaceRNG = uint256(Random.uniform(pool, 1, 30)); 

        if (leftFaceRNG <= 10) {
        leftFacePartID = '<g id="body"><path d="m424.5 41.5l-62.5 43.5l-120 -3l-77 -40l36 60l-34 140l45 139l11 53l52 3l3 -58l75 -2l12 55l55 -1l-6 -58l29 -136l-50 -135l31.5 -60.5z" fill="url(#body)" id="body" stroke="#000000" stroke-width="3"/></g>';	
		
		} else if (leftFaceRNG <= 20) {
        leftFacePartID = '<path d="m392.5 46.5l-30.5 38.5l-120 -3l-44 -39l-40 -4l28 70l-37 328l72 -81l4 79l48 -98l57 0l35 95l20 -78l64 75l-31 -330l40 -54l-65.5 1.5z" fill="url(#body)" id="svg_2" stroke="#000000" stroke-width="3"/>';			    	    
	    
		} else if (leftFaceRNG <= 30) {
        leftFacePartID = '<path d="m302.5 38.5l8.5 53.5l-131 -44l69 61l-149 -18l76 32l13 242l3 35l78 34l-43 -62l95 -26l64 12l24 17l-40 59l79 -32l-29 -321l-117.5 -42.5z" fill="url(#body)" id="svg_2" stroke="#000000" stroke-width="3"/>';		    
        
		}

    }
    
    function getLeftEye(uint256 seed) internal view returns (string memory leftEyePartID){

    bytes32[] memory pool = Random.initLatest(5, seed);     
    
		uint256 leftEyeRNG = uint256(Random.uniform(pool, 1, 60)); 


        if (leftEyeRNG <= 10) {
        leftEyePartID = '  <g id="right_eye"><ellipse cx="355" cy="145" fill="#ffffff" rx="36" ry="40.5" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="350" cy="136" fill="#000000" rx="17.5" ry="19.5" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="347" cy="132" fill="#ffffff" rx="6.51961" ry="6.15789" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="355" cy="142" fill="#ffffff" rx="3.7745" ry="3.42105" stroke-width="3" transform="rotate(0 0 0)"/></g>';	
		
		} else if (leftEyeRNG <= 20) {
        leftEyePartID = '<g id="left_eye"><ellipse cx="231" cy="154" fill="#ffffff" rx="28" ry="32" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="231" cy="155" fill="#000000" rx="15" ry="16" stroke="#000000" stroke-width="3" transform="rotate(160 231 155)"/><ellipse cx="233" cy="157" fill="#ffffff" rx="5" ry="5" stroke="#000000" stroke-width="3" transform="rotate(160 233 157)"/><ellipse cx="224" cy="152" fill="#ffffff" rx="3" ry="2" stroke="#000000" stroke-width="3" transform="rotate(160 224 152)"/></g>';			    	    
	    
		} else if (leftEyeRNG <= 30) {
        leftEyePartID = '<g id="svg_20" transform="rotate(-20 355.5 153.5)"><rect fill="#ffffff" height="48.73076" id="svg_4" stroke="#000000" stroke-width="3" width="86.29892" x="312.35054" y="129.13462"/><rect fill="#000000" height="58.98987" id="svg_5" stroke="#000000" stroke-width="3" width="45.48186" x="333.34217" y="124.00507"/><rect fill="#ffffff" height="11.5415" id="svg_7" stroke="#000000" stroke-width="3" width="12.82822" x="350.83519" y="158.62955"/><rect fill="#ffffff" height="21.8006" id="svg_15" stroke="#000000" stroke-width="3" width="18.65923" x="342.67178" y="135.54656"/></g>';		    
	    
		} else if (leftEyeRNG <= 40) {
        leftEyePartID = '<g id="svg_21" transform="rotate(15 240.5 148.5)"><rect fill="#ffffff" height="38" id="svg_22" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="74" x="203.5" y="129.5"/><rect fill="#000000" height="46" id="svg_23" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="39" x="221.5" y="125.5"/><rect fill="#ffffff" height="9" id="svg_24" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="11" x="236.5" y="152.5"/><rect fill="#ffffff" height="17" id="svg_25" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="16" x="229.5" y="134.5"/></g>';		    
	    
		} else if (leftEyeRNG <= 50) {
        leftEyePartID = '<path d="m399.69731 125.1338l-26.44613 33.21831l-33.46245 -36.35211l-7.55604 16.29577l30.22415 30.0845l-21.58868 31.33803l14.03264 11.28169l17.27094 -33.84507c0 0 31.8433 31.96479 35.0816 28.20422c3.2383 -3.76056 5.39717 -25.07042 6.4766 -23.8169c1.07943 1.25352 -21.58868 -16.29577 -22.12839 -16.92253c-0.53972 -0.62676 19.96952 -28.20422 19.42981 -28.83098c-0.53972 -0.62676 -11.33405 -10.65493 -11.33405 -10.65493z" fill="#000000" id="svg_29" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" transform="rotate(180 373 166.5)"/>';		    
	    
		} else if (leftEyeRNG <= 60) {
        leftEyePartID = ' <path d="m264.39821 138.42958l-20.9321 25.75352l-26.48551 -28.1831l-5.9806 12.6338l23.9224 23.32394l-17.08743 24.29577l11.10683 8.74648l13.66994 -26.23944c0 0 25.20396 24.78169 27.76707 21.8662c2.56311 -2.91549 4.27186 -19.43662 5.12623 -18.46479c0.85437 0.97183 -17.08743 -12.6338 -17.51461 -13.11972c-0.42719 -0.48592 15.80587 -21.8662 15.37868 -22.35211c-0.42719 -0.48592 -8.9709 -8.26056 -8.9709 -8.26056z" fill="#000000" id="svg_28" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3"/>';	
	 
        
		}
    
    }    

    function getMouth(uint256 seed) internal view returns (string memory mouthPartID){

    bytes32[] memory pool = Random.initLatest(6, seed);        
        
		uint256 mouthRNG = uint256(Random.uniform(pool, 1, 30)); 


        if (mouthRNG <= 10) {
        mouthPartID = '<path d="m198.5 279.5c1 0 45 28 44.5 27.5c-0.5 -0.5 15.5 -26.5 15 -27c-0.5 -0.5 35.5 23.5 36.5 23.5c1 0 27 -26 26.5 -26.5c-0.5 -0.5 23.5 23.5 23 23c-0.5 -0.5 25.5 -26.5 25 -27c-0.5 -0.5 25.5 33.5 26.5 34.5c1 1 14 -27 13.5 -27.5c-0.5 -0.5 -24.5 -11.5 -25 -12c-0.5 -0.5 -179.5 3.5 -180 3c-0.5 -0.5 -5.5 8.5 -5.5 8.5z" fill="url(#mouth)" id="svg_27" stroke="#000000" stroke-width="3"/>';	
		
		} else if (mouthRNG <= 20) {
        mouthPartID = '  <g id="mouth"><path d="m195.5 218.5c6 1 48 21 47.5 20.5c-0.5 -0.5 27.5 0.5 28.5 0.5c1 0 17 1 26 1c9 0 42 1 53 -3c11 -4 36 -9 35.5 -9.5c-0.5 -0.5 21.5 -7.5 21 -8c-0.5 -0.5 11.5 -1.5 11 -2c-0.5 -0.5 7.5 15.5 7 15c-0.5 -0.5 -45.5 5.5 -46 5c-0.5 -0.5 5.5 23.5 5 23c-0.5 -0.5 -15.5 4.5 -16 4c-0.5 -0.5 -8.5 -16.5 -9 -17c-0.5 -0.5 -21.5 2.5 -22 2c-0.5 -0.5 2.5 16.5 2 16c-0.5 -0.5 -21.5 3.5 -22 3c-0.5 -0.5 -0.5 -16.5 -1 -17c-0.5 -0.5 -18.5 -0.5 -19 -1c-0.5 -0.5 -11.5 17.5 -12 17c-0.5 -0.5 -23.5 0.5 -24 0c-0.5 -0.5 6.5 -18.5 6 -19c-0.5 -0.5 -15.5 2.5 -16 2c-0.5 -0.5 -7.5 15.5 -8 15c-0.5 -0.5 -21.5 -0.5 -22 -1c-0.5 -0.5 6.5 -21.5 6 -22c-0.5 -0.5 -46.5 -22.5 -47 -23c-0.5 -0.5 15.5 -1.5 15.5 -1.5z" fill="url(#mouth)" id="mouth" stroke="#000000" stroke-width="3"/></g>';			    	    
	    
		} else if (mouthRNG <= 30) {
        mouthPartID = '<path d="m232.5 275.5l20.5 21.5c0 0 18.5 13.5 19.5 13.5c1 0 30 9 34 9c4 0 37 -12 36.5 -12.5c-0.5 -0.5 25.5 -15.5 25 -16c-0.5 -0.5 18.5 -56.5 18 -57c-0.5 -0.5 -41.5 43.5 -42 43c-0.5 -0.5 -61.5 16.5 -62 16c-0.5 -0.5 -49.5 -17.5 -49.5 -17.5z" fill="url(#mouth)" id="svg_31" stroke="#000000" stroke-width="3"/>';		    
        
		}
    
    }    
    
    function getRightEye(uint256 seed) internal view returns (string memory rightEyePartID){

    bytes32[] memory pool = Random.initLatest(7, seed);        
        
		uint256 rightEyeRNG = uint256(Random.uniform(pool, 1, 60)); 


        if (rightEyeRNG <= 10) {
        rightEyePartID = '  <g id="right_eye"><ellipse cx="355" cy="145" fill="#ffffff" rx="36" ry="40.5" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="350" cy="136" fill="#000000" rx="17.5" ry="19.5" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="347" cy="132" fill="#ffffff" rx="6.51961" ry="6.15789" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="355" cy="142" fill="#ffffff" rx="3.7745" ry="3.42105" stroke-width="3" transform="rotate(0 0 0)"/></g>';	
		
		} else if (rightEyeRNG <= 20) {
        rightEyePartID = '<g id="left_eye"><ellipse cx="231" cy="154" fill="#ffffff" rx="28" ry="32" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="231" cy="155" fill="#000000" rx="15" ry="16" stroke="#000000" stroke-width="3" transform="rotate(160 231 155)"/><ellipse cx="233" cy="157" fill="#ffffff" rx="5" ry="5" stroke="#000000" stroke-width="3" transform="rotate(160 233 157)"/><ellipse cx="224" cy="152" fill="#ffffff" rx="3" ry="2" stroke="#000000" stroke-width="3" transform="rotate(160 224 152)"/></g>';			    	    
	    
		} else if (rightEyeRNG <= 30) {
        rightEyePartID = '<g id="svg_20" transform="rotate(-20 355.5 153.5)"><rect fill="#ffffff" height="48.73076" id="svg_4" stroke="#000000" stroke-width="3" width="86.29892" x="312.35054" y="129.13462"/><rect fill="#000000" height="58.98987" id="svg_5" stroke="#000000" stroke-width="3" width="45.48186" x="333.34217" y="124.00507"/><rect fill="#ffffff" height="11.5415" id="svg_7" stroke="#000000" stroke-width="3" width="12.82822" x="350.83519" y="158.62955"/><rect fill="#ffffff" height="21.8006" id="svg_15" stroke="#000000" stroke-width="3" width="18.65923" x="342.67178" y="135.54656"/></g>';		    
	    
		} else if (rightEyeRNG <= 40) {
        rightEyePartID = '<g id="svg_21" transform="rotate(15 240.5 148.5)"><rect fill="#ffffff" height="38" id="svg_22" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="74" x="203.5" y="129.5"/><rect fill="#000000" height="46" id="svg_23" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="39" x="221.5" y="125.5"/><rect fill="#ffffff" height="9" id="svg_24" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="11" x="236.5" y="152.5"/><rect fill="#ffffff" height="17" id="svg_25" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" width="16" x="229.5" y="134.5"/></g>';		    
	    
		} else if (rightEyeRNG <= 50) {
        rightEyePartID = '<path d="m399.69731 125.1338l-26.44613 33.21831l-33.46245 -36.35211l-7.55604 16.29577l30.22415 30.0845l-21.58868 31.33803l14.03264 11.28169l17.27094 -33.84507c0 0 31.8433 31.96479 35.0816 28.20422c3.2383 -3.76056 5.39717 -25.07042 6.4766 -23.8169c1.07943 1.25352 -21.58868 -16.29577 -22.12839 -16.92253c-0.53972 -0.62676 19.96952 -28.20422 19.42981 -28.83098c-0.53972 -0.62676 -11.33405 -10.65493 -11.33405 -10.65493z" fill="#000000" id="svg_29" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" transform="rotate(180 373 166.5)"/>';		    
	    
		} else if (rightEyeRNG <= 60) {
        rightEyePartID = ' <path d="m264.39821 138.42958l-20.9321 25.75352l-26.48551 -28.1831l-5.9806 12.6338l23.9224 23.32394l-17.08743 24.29577l11.10683 8.74648l13.66994 -26.23944c0 0 25.20396 24.78169 27.76707 21.8662c2.56311 -2.91549 4.27186 -19.43662 5.12623 -18.46479c0.85437 0.97183 -17.08743 -12.6338 -17.51461 -13.11972c-0.42719 -0.48592 15.80587 -21.8662 15.37868 -22.35211c-0.42719 -0.48592 -8.9709 -8.26056 -8.9709 -8.26056z" fill="#000000" id="svg_28" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3"/>';	
	 
        
		}
    
    }   

    function getRightFace(uint256 seed) internal view returns (string memory rightFacePartID){

    bytes32[] memory pool = Random.initLatest(8, seed);        
        
		uint256 rightFaceRNG = uint256(Random.uniform(pool, 1, 30)); 

        if (rightFaceRNG <= 10) {
        rightFacePartID = '<g id="nose"><path d="m293.5 173.5l-21.5 26.39474l7.31915 15.21053l12.80851 -12.52632l16.46809 13.42105l6.40426 -18.78947l-21.5 -23.71053l-0.00001 0z" fill="url(#nose)" id="nose" stroke="#000000" stroke-width="3"/></g>';	
		
		} else if (rightFaceRNG <= 20) {
        rightFacePartID = '  <path d="m284.5 219.5l-23.5 -17.60526l0.31915 31.21053l32.80851 -11.52632l30.46809 11.42105l5.40426 -34.78947l-25.5 22.28947l-20.00001 -1z" fill="url(#nose)" id="svg_44" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" transform="rotate(180 295.5 215.658)"/>';			    	    
	    
		} else if (rightFaceRNG <= 30) {
        rightFacePartID = '<path d="m282.01337 252.73685l-15.49863 -22.08324l-0.51474 16.77921l25.56027 -24.61701l26.05893 21.14856l1.06166 -14.88732l-20.03481 23.23188l-16.63268 0.42793z" fill="url(#nose)" id="svg_44" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-width="3" transform="rotate(180 292.34 237.776)"/>';		    
	   
		}
    
    }

    function _registerToken(string memory value) private {
        uint256 tokenId = totalSupply();
        
        id_to_value[tokenId] = value;
        value_to_id[value] = tokenId;

        
        
        _mint(msg.sender, tokenId);
    }

    
    uint public constant tokenLimit = 9999;

    
    
    function createFace() public payable {
        
        
        if (totalSupply() < 2000) {
        require(msg.value == 6 finney);
        }

        else if (totalSupply() < 4000) {
        require(msg.value == 8 finney);
        }
        else if (totalSupply() < 6000) {
        require(msg.value == 10 finney);
        }
        else if (totalSupply() < 8000) {
        require(msg.value == 12 finney);
        }
        else {
        require(msg.value == 14 finney);
        }

//       require(block.timestamp < 1574711999, "ChainFaces sale has completed. They are now only available on the secondary market. ");
        require(totalSupply() <= tokenLimit, "ChainFaces sale has completed. They are now only available on the secondary market. ");
 

        address(0x63a9dbCe75413036B2B778E670aaBd4493aAF9F3).transfer(msg.value/5*4);
        address(0x027Fb48bC4e3999DCF88690aEbEBCC3D1748A0Eb).transfer(msg.value/5);

        string[1] memory header = [ '<svg width="640" height="480" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"><defs><radialGradient cx="0.51434" cy="0.51953" id="mouth" r="1.30605" spreadMethod="pad"><stop offset="0" stop-color="#343e72" stop-opacity="0.98438"/><stop offset="1" stop-color="#204cbc" stop-opacity="0.99219"/></radialGradient><radialGradient cx="0.5" cy="0.5" id="nose" r="1.18799" spreadMethod="pad"><stop offset="0" stop-color="#6d75f2" stop-opacity="0.99609"/><stop offset="1" stop-color="#000000"/></radialGradient><radialGradient id="body" r="1.56261" spreadMethod="pad"><stop offset="0" stop-color="#a9abc9" stop-opacity="0.99609"/><stop offset="1" stop-color="#5db9d8" stop-opacity="0.99609"/></radialGradient></defs>' ];
/*
        string[1] memory leftFaceCharacters = [ '<g id="body"><path d="m424.5,41.5l-62.5,43.5l-120,-3l-77,-40l36,60l-34,140l45,139l11,53l52,3l3,-58l75,-2l12,55l55,-1l-6,-58l29,-136l-50,-135l31.5,-60.5z" fill="url(#body)" id="body" stroke="#000000" stroke-width="3"/></g>' ];
        string[1] memory leftEyeCharacters = ['<g id="right_eye"><ellipse cx="355" cy="145" fill="#ffffff" rx="36" ry="40.5" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="350" cy="136" fill="#000000" rx="17.5" ry="19.5" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="347" cy="132" fill="#ffffff" rx="6.51961" ry="6.15789" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="355" cy="142" fill="#ffffff" rx="3.7745" ry="3.42105" stroke-width="3" transform="rotate(0 0 0)"/></g>'];
        string[1] memory mouthCharacters = ['<g id="mouth"><path d="m195.5,218.5c6,1 48,21 47.5,20.5c-0.5,-0.5 27.5,0.5 28.5,0.5c1,0 17,1 26,1c9,0 42,1 53,-3c11,-4 36,-9 35.5,-9.5c-0.5,-0.5 21.5,-7.5 21,-8c-0.5,-0.5 11.5,-1.5 11,-2c-0.5,-0.5 7.5,15.5 7,15c-0.5,-0.5 -45.5,5.5 -46,5c-0.5,-0.5 5.5,23.5 5,23c-0.5,-0.5 -15.5,4.5 -16,4c-0.5,-0.5 -8.5,-16.5 -9,-17c-0.5,-0.5 -21.5,2.5 -22,2c-0.5,-0.5 2.5,16.5 2,16c-0.5,-0.5 -21.5,3.5 -22,3c-0.5,-0.5 -0.5,-16.5 -1,-17c-0.5,-0.5 -18.5,-0.5 -19,-1c-0.5,-0.5 -11.5,17.5 -12,17c-0.5,-0.5 -23.5,0.5 -24,0c-0.5,-0.5 6.5,-18.5 6,-19c-0.5,-0.5 -15.5,2.5 -16,2c-0.5,-0.5 -7.5,15.5 -8,15c-0.5,-0.5 -21.5,-0.5 -22,-1c-0.5,-0.5 6.5,-21.5 6,-22c-0.5,-0.5 -46.5,-22.5 -47,-23c-0.5,-0.5 15.5,-1.5 15.5,-1.5z" fill="url(#mouth)" id="mouth" stroke="#000000" stroke-width="3"/></g>' ];
        string[1] memory rightEyeCharacters = [  '<g id="left_eye"><ellipse cx="231" cy="154" fill="#ffffff" rx="28" ry="32" stroke="#000000" stroke-width="3" transform="rotate(0 0 0)"/><ellipse cx="231" cy="155" fill="#000000" rx="15" ry="16" stroke="#000000" stroke-width="3" transform="rotate(160 231 155)"/><ellipse cx="233" cy="157" fill="#ffffff" rx="5" ry="5" stroke="#000000" stroke-width="3" transform="rotate(160 233 157)"/><ellipse cx="224" cy="152" fill="#ffffff" rx="3" ry="2" stroke="#000000" stroke-width="3" transform="rotate(160 224 152)"/></g>'];
        string[1] memory rightFaceCharacters = ['<g id="nose"><path d="m293.5,173.5l-21.5,26.39474l7.31915,15.21053l12.80851,-12.52632l16.46809,13.42105l6.40426,-18.78947l-21.5,-23.71053l-0.00001,0z" fill="url(#nose)" id="nose" stroke="#000000" stroke-width="3"/></g>' ];
*/

		uint256 headerID = 0;
        string memory bodyPartID = getLeftFace(totalSupply());
        string memory leftEyePartID = getLeftEye(totalSupply());
        string memory mouthPartID = getMouth(totalSupply());
        string memory rightEyePartID = getRightEye(totalSupply());
        string memory nosePartID = getRightFace(totalSupply());
        
        string memory faceAssembly = string(abi.encodePacked(header[headerID], bodyPartID, leftEyePartID, mouthPartID, rightEyePartID, nosePartID, "</svg>"));


        _registerToken(faceAssembly);
        
    }

   function integerToString(uint _i) internal pure 
      returns (string memory) {
      
      if (_i == 0) {
         return "0";
      }
      uint j = _i;
      uint len;
      
      while (j != 0) {
         len++;
         j /= 10;
      }
      bytes memory bstr = new bytes(len);
      uint k = len - 1;
      
      while (_i != 0) {
         bstr[k--] = byte(uint8(48 + _i % 10));
         _i /= 10;
      }
      return string(bstr);
   }


    function tokenURI(uint256 id) external view returns (string memory) {
        require(_exists(id), "ERC721Metadata: URI query for nonexistent token");
        return string(abi.encodePacked("https://chainfacesrinkeby.azurewebsites.net/api/HttpTrigger?id=", integerToString(id)));
    }
    
    function getFace(uint256 id) public view returns (string memory face) {
        return id_to_value[id];
    }

    function getGolfScore(uint id) public view returns (uint256 golfScore) {
        return idToGolfScore[id];
    }    

    function getPercentBear(uint id) public view returns (uint256 percentBear) {
        return idToPercentBear[id];
    }   
    
    function getFaceSymmetry(uint id) public view returns (uint256 faceSymmetry) {
        return idToFaceSymmetry[id];
    }       

    function getTextColor(uint id) public view returns (uint256 textColor) {
        return idToTextColor[id];
    }   
    
    function getBackgroundColor(uint id) public view returns (uint256 backgroundColor) {
        return idToBackgroundColor[id];
    }         



}
