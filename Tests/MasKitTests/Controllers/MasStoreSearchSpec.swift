//
//  MasStoreSearchSpec.swift
//  MasKitTests
//
//  Created by Ben Chatelain on 1/4/19.
//  Copyright © 2019 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import MasKit

class MasStoreSearchSpec: QuickSpec {
    override func spec() {
        describe("store") {
            context("when searched") {
                it("can find slack") {
                    let networkSession = NetworkSessionMockFromFile(responseFile: "search/slack.json")
                    let storeSearch = MasStoreSearch(networkManager: NetworkManager(session: networkSession))

                    var results: [SearchResult]
                    do {
                        results = try storeSearch.search(for: "slack")
                        expect(results.count) == 39
                    } catch {
                        let maserror = error as! MASError
                        if case .jsonParsing(let nserror) = maserror {
                            fail("\(maserror) \(nserror!)")
                        }
                    }
                }
            }

            context("when lookup used") {
                it("can find slack") {
                    let appId = 803_453_959
                    let networkSession = NetworkSessionMockFromFile(responseFile: "lookup/slack.json")
                    let storeSearch = MasStoreSearch(networkManager: NetworkManager(session: networkSession))

                    var lookup: SearchResult?
                    do {
                        lookup = try storeSearch.lookup(app: appId)
                    } catch {
                        let maserror = error as! MASError
                        if case .jsonParsing(let nserror) = maserror {
                            fail("\(maserror) \(nserror!)")
                        }
                    }

                    guard let result = lookup else { fatalError("lookup result was nil") }

                    expect(result.trackId) == appId
                    expect(result.bundleId) == "com.tinyspeck.slackmacgap"
                    expect(result.price) == 0
                    expect(result.sellerName) == "Slack Technologies, Inc."
                    expect(result.sellerUrl) == "https://slack.com"
                    expect(result.trackName) == "Slack"
                    expect(result.trackViewUrl) == "https://itunes.apple.com/us/app/slack/id803453959?mt=12&uo=4"
                    expect(result.version) == "3.3.3"
                }
            }
        }
    }
}
