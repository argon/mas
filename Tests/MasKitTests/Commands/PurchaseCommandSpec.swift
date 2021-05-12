//
//  PurchaseCommandSpec.swift
//  MasKitTests
//
//  Created by Maximilian Blochberger on 2020-03-21.
//  Copyright © 2020 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import MasKit

public class PurchaseCommandSpec: QuickSpec {
    public override func spec() {
        beforeSuite {
            MasKit.initialize()
        }
        describe("purchase command") {
            it("purchases apps") {
                let cmd = PurchaseCommand()
                let result = cmd.run(PurchaseCommand.Options(appIds: []))
                print(result)
                //                expect(result).to(beSuccess())
            }
        }
    }
}
