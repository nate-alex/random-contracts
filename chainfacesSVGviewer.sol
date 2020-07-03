pragma solidity ^0.5.14;

library Buffer {
	function hasCapacityFor(bytes memory buffer, uint256 needed) internal pure returns (bool) {
		uint256 size;
		uint256 used;
		
		assembly {
			size := mload(buffer)
			used := mload(add(buffer, 32))
		}
		return size >= 32 && used <= size - 32 && used + needed <= size - 32;
	}
	
	function toString(bytes memory buffer) internal pure returns (string memory) {
		require(hasCapacityFor(buffer, 0), "Buffer.toString: invalid buffer");
		string memory ret;
		assembly {
			ret := add(buffer, 32)
		}
		return ret;
	}
	
	function append(bytes memory buffer, string memory str) internal view {
		require(hasCapacityFor(buffer, bytes(str).length), "Buffer.append: no capacity");
		assembly {
			let len := mload(add(buffer, 32))
			pop(staticcall(gas, 0x4, add(str, 32), mload(str), add(len, add(buffer, 64)), mload(str)))
			mstore(add(buffer, 32), add(len, mload(str)))
		}
	}
	
	function rect(bytes memory buffer, int256 xpos, int256 ypos, uint256 width, uint256 height, uint256 rgb) internal pure {
		require(hasCapacityFor(buffer, 102), "Buffer.rect: no capacity");
		assembly {
			function numbx1(x, v) -> y {
				// v must be in the closed interval [0, 9]
				// otherwise it outputs junk
				mstore8(x, add(v, 48))
				y := add(x, 1)
			}
			function numbx2(x, v) -> y {
				// v must be in the closed interval [0, 99]
				// otherwise it outputs junk
				y := numbx1(numbx1(x, div(v, 10)), mod(v, 10))
			}
			function numbu3(x, v) -> y {
				// v must be in the closed interval [0, 999]
				// otherwise only the last 3 digits will be converted
				switch lt(v, 100)
				case 0 {
					// without input value sanitation: y := numbx2(numbx1(x, div(v, 100)), mod(v, 100))
					y := numbx2(numbx1(x, mod(div(v, 100), 10)), mod(v, 100))
				}
				default {
    				switch lt(v, 10)
    				case 0 { y := numbx2(x, v) }
    				default { y := numbx1(x, v) }
				}
			}
			function numbi3(x, v) -> y {
				// v must be in the closed interval [-999, 999]
				// otherwise only the last 3 digits will be converted
				if slt(v, 0) {
					v := add(not(v), 1)
					mstore8(x, 45)  // minus sign
					x := add(x, 1)
				}
				y := numbu3(x, v)
			}
			function hexrgb(x, v) -> y {
				let blo := and(v, 0xf)
				let bhi := and(shr(4, v), 0xf)
				let glo := and(shr(8, v), 0xf)
				let ghi := and(shr(12, v), 0xf)
				let rlo := and(shr(16, v), 0xf)
				let rhi := and(shr(20, v), 0xf)
				mstore8(x,         add(add(rhi, mul(div(rhi, 10), 39)), 48))
				mstore8(add(x, 1), add(add(rlo, mul(div(rlo, 10), 39)), 48))
				mstore8(add(x, 2), add(add(ghi, mul(div(ghi, 10), 39)), 48))
				mstore8(add(x, 3), add(add(glo, mul(div(glo, 10), 39)), 48))
				mstore8(add(x, 4), add(add(bhi, mul(div(bhi, 10), 39)), 48))
				mstore8(add(x, 5), add(add(blo, mul(div(blo, 10), 39)), 48))
				y := add(x, 6)
			}
			function append(x, str, len) -> y {
			    mstore(x, str)
			    y := add(x, len)
			}
			let strIdx := add(mload(add(buffer, 32)), add(buffer, 64))
			strIdx := append(strIdx, '<rect x="', 9)
			strIdx := numbi3(strIdx, xpos)
			strIdx := append(strIdx, '" y="', 5)
			strIdx := numbi3(strIdx, ypos)
			strIdx := append(strIdx, '" width="', 9)
			strIdx := numbu3(strIdx, width)
			strIdx := append(strIdx, '" height="', 10)
			strIdx := numbu3(strIdx, height)
			strIdx := append(strIdx, '" style="fill:#', 15)
			strIdx := hexrgb(strIdx, rgb)
			strIdx := append(strIdx, '; fill-opacity:1.0;"/>\n', 23)
			mstore(add(buffer, 32), sub(sub(strIdx, buffer), 64))
		}
	}
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

contract chainFaces {
    function ownerOf(uint256 _tokenId) public view returns (address owner);
    function getFaceSymmetry(uint id) public view returns (uint256 faceSymmetry);
    function getPercentBear(uint id) public view returns (uint256 percentBear);
    function getGolfScore(uint id) public view returns (uint256 golfScore);
    function getFace(uint256 id) public view returns (string memory face);
    function getTextColor(uint256 id) public view returns (uint256 textColor);
    function getBackgroundColor(uint256 id) public view returns (uint256 backgroundColor);
}

contract ChainFaceSVGviewer {
    using SafeMath for uint256;

    constructor() public {
        chainFacesERC721 = chainFaces(ChainFacesAddress);
    }
    
// <svg width="350" height="350" style="background-color:#000000;"><text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-size="75px" fill="#ff5f5a">ʕ◕ᴥ◕ʔ</text></svg>    
    
    address public ChainFacesAddress = 0xE6Da1E491a9442a2A91453d1C15719b3666fd8d3;
    chainFaces chainFacesERC721;
        
    
    function getFaceSVG(uint id) public view returns (string memory faceSVG) {
        
     string memory faceText = chainFacesERC721.getFace(id);
     uint textColorInt = uint(chainFacesERC721.getTextColor(id));
     
     string memory svgZeroes;
     
    if (textColorInt > 16777215) {
         textColorInt = 0;
    }
     
    if(textColorInt > 1048576) {
        svgZeroes = "";
    }
    else if(textColorInt > 65536) {
        svgZeroes = "0";
    }
    else if(textColorInt > 4096) {
        svgZeroes = "00";
    }
    else if(textColorInt > 256) {
        svgZeroes = "000";
    }
    else if(textColorInt > 16) {
        svgZeroes = "0000";
    }
    else if(textColorInt > 0) {
        svgZeroes = "00000";
    }
    else {
         svgZeroes = "000000";
    }
     
     uint backgroundColorInt = uint(chainFacesERC721.getBackgroundColor(id));
     
     string memory textColorHex = toHexString(textColorInt);
     string memory backgroundColorHex = toHexString(backgroundColorInt);
     
    if (id < 8 || id == 77 || id == 80){
        backgroundColorHex = "000000";
    }
    if (chainFacesERC721.ownerOf(id) == 0x442DCCEe68425828C106A3662014B4F131e3BD9b){
        backgroundColorHex = "99FFCC";
    }
     
     string memory svgHeader = '<svg width="350" height="350" style="background-color:#';
     string memory svgBackgroundColor = backgroundColorHex;
     string memory svgMiddle1 = ';"><text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-size="75px" fill="#';
     string memory svgMiddle2 = svgZeroes;
     string memory svgTextColor = textColorHex;
     string memory svgMiddle3 = '">';
     string memory svgFaceText = faceText;
     string memory svgFooter = '</text></svg>';
     

    faceSVG = string(abi.encodePacked(svgHeader, svgBackgroundColor, svgMiddle1, svgMiddle2, svgTextColor, svgMiddle3, svgFaceText, svgFooter));

    }  

function toHexDigit(uint8 d) pure internal returns (byte) {
    if (0 <= d && d <= 9) {
        return byte(uint8(byte('0')) + d);
    } else if (10 <= uint8(d) && uint8(d) <= 15) {
        return byte(uint8(byte('a')) + d - 10);
    }
    // revert("Invalid hex digit");
    revert();
}
    
function toHexString(uint a) public pure returns (string memory) {
    uint count = 0;
    uint b = a;
    while (b != 0) {
        count++;
        b /= 16;
    }
    bytes memory res = new bytes(count);
    for (uint i=0; i<count; ++i) {
        b = a % 16;
        res[count - i - 1] = toHexDigit(uint8(b));
        a /= 16;
    }
    return string(res);
}

function readScoreByID(uint id) public view returns (uint256 golfScoreByID) {
    golfScoreByID = chainFacesERC721.getGolfScore(id);
}


/*
        uint256 textColor = (8*(30-faceGolfScore))+(256*(8*(30-faceGolfScore)));
        uint256 backgroundColor = (2*(100-percentBear))+(256*(2*(100-percentBear)+20))+(65536*(2*(100-percentBear)+56));
*/    
    
}



















