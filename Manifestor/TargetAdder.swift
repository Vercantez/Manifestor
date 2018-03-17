//
//  TargetAdder.swift
//  Syntacc
//
//  Created by Miguel Salinas on 3/17/18.
//  Copyright © 2018 Miguel Salinas. All rights reserved.
//

import Foundation
import SwiftSyntax

class TargetAdder: SyntaxRewriter {
    let newTarget: FunctionCallExprSyntax
    init(newTarget: FunctionCallExprSyntax) {
        self.newTarget = newTarget
    }
    override func visit(_ node: FunctionCallArgumentSyntax) -> Syntax {
        if node.label?.text == "targets", let targets = node.expression as? ArrayExprSyntax, ((node.parent?.parent as? FunctionCallExprSyntax)?.calledExpression as? IdentifierExprSyntax)?.identifier.text == "Package" {
            let newElement = SyntaxFactory.makeArrayElement(expression: newTarget, trailingComma: SyntaxFactory.makeCommaToken())
            let newTargets = targets.withElements(targets.elements.inserting(newElement, at: 0))
            return super.visit(node.withExpression(newTargets))
        }
        return super.visit(node)
    }
}
