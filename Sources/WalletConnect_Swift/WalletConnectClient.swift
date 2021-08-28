// 

import Foundation

public class WalletConnectClient {
    
    public init(relayUrl: URL = URL(string: "wss://relay.walletconnect.org/?protocol=wc&version=2")!) {
    }
    
    public func pair(with url: String) throws {
        guard let pairingParamsUri = PairParamsUri(url) else {
            throw WalletConnectError.PairingParamsUriInitialization
        }
        let proposal = formatPairingProposal(from: pairingParamsUri)
    }
    
    func formatPairingProposal(from uri: PairParamsUri) -> PairingProposal {
        return PairingProposal(topic: uri.topic,
                               relay: uri.relay,
                               proposer: PairingProposer(publicKey: uri.publicKey,
                                                         controller: uri.controller),
                               signal: PairingSignal(params: PairingSignal.Params(uri: uri.raw)),
                               permissions: PairingProposedPermissions(jsonrpc: PairingProposedPermissions.JSONRPC(methods: [])),
                               ttl: Pairing.defaultTtl)
    }
}

protocol SequenceEngine {
    var sequence: Sequence {get}
    var relay: Relay {get}
}

enum SequenceStatus {
    case pending
    case proposed
    case responded
    case settled
}

protocol Sequence {
    var status: SequenceStatus {get set}
}

class Relay {
    func publish(){}
    func subscribe(){}
    func unsubscribe(){}
}