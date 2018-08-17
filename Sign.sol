pragma solidity ^0.4.0;


const SignVerifyArtifact = require('./contracts/SignAndVerifyExample')
const SignVerify = contract(SignVerifyArtifact)
SignVerify.setProvider(provider)
//...
SignVerify
  .deployed()
  .then(instance => {
    let fixed_msg = `\x19Ethereum Signed Message:\n${msg.length}${msg}`
    let fixed_msg_sha = web3.sha3(fixed_msg)
    return instance.verify.call(
      fixed_msg_sha,
      v_decimal,
      r,
      s
    )
  })
  .then(data => {
    console.log('-----data------')
    console.log(`input addr ==> ${addr}`)
    console.log(`output addr => ${data}`)
  })
  .catch(e => {
    console.error(e)
  })
