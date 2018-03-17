//
//  main.swift
//  Manifestor
//
//  Created by Miguel Salinas on 3/13/18.
//  Copyright © 2018 Miguel Salinas. All rights reserved.
//

import Foundation
import SwiftSyntax

if CommandLine.arguments.count == 1 {
    print("\(CommandLine.arguments[0]): Please provide the Package.swift file as an argument")
    exit(1)
}

// Parse the Package.swift manifest file
let currentFile = URL(fileURLWithPath: CommandLine.arguments[1])
let currentFileContents = try String(contentsOf: currentFile)
let parsed = try SourceFileSyntax.parse(currentFile)

print("Enter new target name:")
let name = readLine()

print("Enter dependencies separated by commas (,)")
let dependencies = readLine()?.split(separator: ",").map({return String($0)})

guard let name = name, let dependencies = dependencies else {
    exit(1)
}
let target = ComponentFactory.makeTarget(name: name, dependencies: dependencies)

let depAdd = TargetAdder(newTarget: target)

print(depAdd.visit(parsed))
