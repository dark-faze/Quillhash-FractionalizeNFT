# Fractionalize NFT Token into ERC20 Tokens

Fractionalize NFT Token into ERC20 Tokens and put the tokens up for an auction.

## DEMO VIDEO
Yt Demo Video Link: [https://youtu.be/erEeBwaYxyc](https://youtu.be/erEeBwaYxyc)

## Steps

```python
Step1: Deploy NFT.sol and mint an nft. TokenURI could be a url to a json data. 
Example: https://jsonkeeper.com/b/RES0

Step2: Deploy fractionalize.sol and pass the NFTs contract address in the constructor.

Step3: Approve fractionalize.sol to transfer NFT fron wallet to itself by using approve
from NFT Contract and passing the fractionalize.sol address with the tokenID(1).

Step4: Now we will be able to use our lockandMint, pass the tokenID(1) and amount of erc 
tokens to be minted.

Step5: Get the contract address for FractionalizeERC20 which was deployed automatically 
when lockandMint was called.

Step6: Deploy dutchAuction.sol and give approval to dutchAuction from FractionalizeERC20 
to transfer FrNFT tokens from main wallet to buyers wallet.

Step7: After approval we can buy the tokens with another wallet and after we send the eth 
and amount of FrNFT we want to buy and the amount will be transferred to our another wallet.
```
## Deployed Contracts:

**NFT Contract** : 0x3bAF2853EdCd6D9f307f3B8BD1a98637942dF037

**Fractionalize** : 0x57BDA807E6E2E35C278cbB1BaE428DA954411d95

**FractionalizeERC20** : 0xB1bc52095290eBD5171D61e519125ddD0119f0CE

**DutchAuction** : 0x283e7d0FAC768b526d756B24380fF91C04258DE8
