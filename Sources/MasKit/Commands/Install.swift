//
//  Install.swift
//  mas-cli
//
//  Created by Andrew Naylor on 21/08/2015.
//  Copyright (c) 2015 Andrew Naylor. All rights reserved.
//

import Commandant
import CommerceKit

/// Installs previously purchased apps from the Mac App Store.
public struct InstallCommand: CommandProtocol {
    public typealias Options = InstallOptions
    public let verb = "install"
    public let function = "Install from the Mac App Store"

    private let appLibrary: AppLibrary

    /// Public initializer.
    public init() {
        self.init(appLibrary: MasAppLibrary())
    }

    /// Internal initializer.
    /// - Parameter appLibrary: AppLibrary manager.
    init(appLibrary: AppLibrary = MasAppLibrary()) {
        self.appLibrary = appLibrary
    }

    /// Runs the command.
    public func run(_ options: Options) -> Result<Void, MASError> {
        // Try to download applications with given identifiers and collect results
        let appIds = options.appIds.filter { appId in
            if let product = appLibrary.installedApp(forId: appId), !options.forceInstall {
                printWarning("\(product.appName) is already installed")
                return false
            }

            return true
        }

        do {
            try downloadAll(appIds).wait()
        } catch {
            return .failure(error as? MASError ?? .downloadFailed(error: error as NSError))
        }

        return .success(())
    }
}

public struct InstallOptions: OptionsProtocol {
    let appIds: [UInt64]
    let forceInstall: Bool

    public static func create(_ appIds: [Int]) -> (_ forceInstall: Bool) -> InstallOptions {
        { forceInstall in
            InstallOptions(appIds: appIds.map { UInt64($0) }, forceInstall: forceInstall)
        }
    }

    public static func evaluate(_ mode: CommandMode) -> Result<InstallOptions, CommandantError<MASError>> {
        create
            <*> mode <| Argument(usage: "app ID(s) to install")
            <*> mode <| Switch(flag: nil, key: "force", usage: "force reinstall")
    }
}
