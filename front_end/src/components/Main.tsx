import { useEthers } from "@usedapp/core"
import helperConfig from "../helper-config.json"
import networkMapping from "../chain-info/deployments/map.json"
import brownieConfig from "../brownie-config.json"
import { constants } from "ethers"

export const Main = () => {
    const { chainId, error } = useEthers()
    const networkName = chainId ? helperConfig[chainId] : "dev"
    let stringChainId = String(chainId)
    const dappTokenAddress = chainId ? networkMapping[
        stringChainId]["DappToken"][0] : constants.AddressZero
    const wethTokenAddress = chainId ? brownieConfig[
        "networks"][networkName]["weth_token"] : constants.AddressZero
    const fauTokenAddress = chainId ? brownieConfig[
        "networks"][networkName]["fau_token"] : constants.AddressZero
    console.log(chainId)
    console.log(networkName)
    return (<div>Hi1</div>)
}
