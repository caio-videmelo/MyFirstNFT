const { ethers } = require("hardhat");
require('dotenv').config({ path: './Teste.env' });

async function main() {
    const signers = await ethers.getSigners();
    const deployer = signers[0];

    console.log("Deployer account:", deployer.address);

    // Obtenha o saldo
    const balance = await deployer.provider.getBalance(deployer.address);
    console.log("Account balance:", ethers.formatEther(balance), "ETH");

    // Verifique se há saldo suficiente para o deploy
    const minimumBalance = ethers.parseEther("0.1");

    // Verifique se o saldo é suficiente
    if (balance.gte(minimumBalance)) { // balance deve ser um BigNumber
        console.log("Saldo suficiente para o deploy.");
    } else {
        throw new Error(`Saldo insuficiente para o deploy. Necessário pelo menos ${ethers.formatEther(minimumBalance)} ETH.`);
    }

    const MindfulMomentsCollection = await ethers.getContractFactory("MindfulMomentsCollection");

    let nft;
    try {
        nft = await MindfulMomentsCollection.deploy();
        console.log("Deploy transaction hash:", nft.deployTransaction.hash);

        await nft.deployTransaction.wait();
        console.log("NFT contract deployed to:", nft.address);
    } catch (error) {
        console.error("Error deploying contract:", error);
        process.exit(1);
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Script error:", error);
        process.exit(1);
    });
