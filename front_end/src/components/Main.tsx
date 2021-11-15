import { userEthers } from "@usedapp/core"
import helperConfig from "../helper-config.json"

export const Main = () => {
    const { chainId } = userEthers()
    const networkName = chainId ? helperConfig[chainId] : "dev"
    return (<div>Hi1</div>)
}
