//
//  SwiftFormatPlugin.swift
//  
//
//  Created by Jay Zisch on 2023/03/04.
//
import PackagePlugin
import Foundation

@main
struct SwiftFormatPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        let swiftFormatTool = try context.tool(named: "swiftformat")
//        let configFile = context.package.directory.appending(".swift-format.json")
//                "--configuration", "\(configFile)",

        return [.buildCommand(
            displayName: "formatting code",
            executable: swiftFormatTool.path,
            arguments: ["-i", "-r","\(target.directory)"]
        )]
    }
}
