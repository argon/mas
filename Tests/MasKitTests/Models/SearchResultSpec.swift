//
//  SearchResultSpec.swift
//  MasKitTests
//
//  Created by Ben Chatelain on 9/2/20.
//  Copyright © 2020 mas-cli. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import MasKit

public class SearchResultSpec: QuickSpec {
    public override func spec() {
        describe("search result") {
            it("can parse things") {
                let data = Data(from: "search/things-that-go-bump.json")
                let decoder = JSONDecoder()
                let result = try decoder.decode(SearchResult.self, from: data)

                expect(result.bundleId) == "uikitformac.com.tinybop.thingamabops"
            }
        }
    }
}
