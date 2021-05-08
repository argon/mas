//
//  ResetCommandSpec.swift
//  MasKitTests
//
//  Created by Ben Chatelain on 2018-12-28.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import MasKit

public class ResetCommandSpec: QuickSpec {
    public override func spec() {
        describe("reset command") {
            it("updates stuff") {
                let cmd = ResetCommand()
                let result = cmd.run(ResetCommand.Options(debug: false))
                print(result)
                //                expect(result).to(beSuccess())
            }
        }
    }
}
