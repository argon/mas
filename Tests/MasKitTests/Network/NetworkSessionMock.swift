//
//  NetworkSessionMock
//  MasKitTests
//
//  Created by Ben Chatelain on 11/13/18.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Foundation
import PromiseKit
@testable import MasKit

/// Mock NetworkSession for testing.
class NetworkSessionMock: NetworkSession {
    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?

    /// Immediately passes data and error to completion handler.
    ///
    /// - Parameters:
    ///   - url: unused
    ///   - completionHandler: Closure which is delivered either data or an error.
    func loadData(from _: URL) -> Promise<Data> {
        guard let data = data else {
            return Promise(error: error ?? MASError.noData)
        }

        return .value(data)
    }
}
