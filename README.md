# Bulls library

It can pack and unpack booleans in uints making it potentially 8x cheaper.

If you want something a little bit too complex for today' distributed technology capabilities and you want it to be cheap enough to be usable. If you need to get rid 'Stack too deep' in big structs. Or if you have an unhealthy obsession with optimization.

For use-case example you can visit Aletheo [repo](https://github.com/SamPorter1984/Aletheo/blob/main/contracts/CampaignMarket.sol). I could see some more use-cases: game settings/statistics? Which for some reason play a role in decision making for decentralized crowd funding or bets in the game?

```
git clone https://github.com/SamPorter1984/Bulls && cd bulls && npm run test
```

Here are some extreme examples from tests(simply storing an array of 256 booleans vs packing them and storing them as uint):

```
tx for bool[256] took 394193 gas.
tx for uint256 took 142366 gas.
```

A bit counter intuitive for some, but storing 256 booleans as is is actually quite cheap in 0.8.x:

```
tx which stores separate 256 bools took 198097 gas.
```

Vs 277204 gas in 0.7.x. Tests however, use external library. Calling another contract is a luxury today, and that's not the only thing you can do to make the results even better.

## How to use:

```
pragma solidity ^0.8.17;
import './Bulls.sol';

contract LibTest {
    using {Bulls.extractBooleans} for uint;
    using {Bulls.packBooleans} for bool[];

    function testPackBooleans(bool[] memory bools) public pure returns (bool[] memory) {
        uint uintBools = bools.packBooleans();
        return uintBools.extractBooleans(256);//256 is the power of 2 you should limit depending on the case to make the tx cheaper
    }
}
```

And in case you need a cheaper compiler, 0.7.6 version is also present:

```
pragma solidity ^0.7.6;
import './Bulls.sol';

contract LibTest {
    using Bulls for uint;
    using Bulls for bool[];

    function testPackBooleans(bool[] memory bools) public pure returns (bool[] memory) {
        uint uintBools = bools.packBooleans();
        return uintBools.extractBooleans(256);
    }
}
```