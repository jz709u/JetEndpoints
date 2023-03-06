//
//  SwiftFormatPlugin.swift
//  
//
//  Created by Jay Zisch on 2023/03/04.
//
import PackagePlugin
import Foundation

@main
struct SwiftFormatTest: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        let swiftFormatTool = try context.tool(named: "swiftformat")
        let toolUrl = URL(string: swiftFormatTool.path.string)
        
        for target in context.package.targets {
            guard let target = target as? SourceModuleTarget else { continue }

            let process = Process()
            print("\(swiftFormatTool.path)")
            process.executableURL = toolUrl
            process.arguments = ["-i", "-r","--lint","quiet","\(target.directory)"]

            try process.run()
            process.waitUntilExit()
            
            if process.terminationReason == .exit && process.terminationStatus == 0 {
                print("Formatted the source code in \(target.directory).")
            }
            else {
                let problem = "\(process.terminationReason):\(process.terminationStatus)"
                Diagnostics.error("swift-format invocation failed: \(problem)")
            }
        }
    }
}
