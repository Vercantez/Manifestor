//
//  ComponentFactory.swift
//  Syntacc
//
//  Created by Miguel Salinas on 3/17/18.
//  Copyright © 2018 Miguel Salinas. All rights reserved.
//

import Foundation
import SwiftSyntax

public class ComponentFactory {
    public static func makeTarget(name: String, dependencies: [String]) -> FunctionCallExprSyntax {
        let dot = SyntaxFactory.makePrefixPeriodToken()
        let identifier = SyntaxFactory.makeIdentifier("target")
        let calledExpr = SyntaxFactory.makeImplicitMemberExpr(dot: dot, name: identifier, declNameArguments: nil)
        let leftParen = SyntaxFactory.makeLeftParenToken()
        
        // Arguments
        let nameLabel = SyntaxFactory.makeStringLiteral("name")
        let colon = SyntaxFactory.makeColonToken(leadingTrivia: Trivia.zero, trailingTrivia: Trivia.spaces(1))
        let nameValueExpr = SyntaxFactory.makeStringLiteralExpr(name)
        let comma = SyntaxFactory.makeCommaToken(leadingTrivia: Trivia.zero, trailingTrivia: Trivia.spaces(1))
        let nameArg = SyntaxFactory.makeFunctionCallArgument(label: nameLabel, colon: colon, expression: nameValueExpr, trailingComma: comma)
        
        let dependencyLabel = SyntaxFactory.makeStringLiteral("dependencies")
        let dependenciesStringLitExprs = dependencies.map({return SyntaxFactory.makeStringLiteralExpr($0)})
        let depArrayElements = dependenciesStringLitExprs.map({return SyntaxFactory.makeArrayElement(expression: $0, trailingComma: ($0 != dependenciesStringLitExprs.last) ? comma : nil)})
        let dependencyArrayElementList = SyntaxFactory.makeArrayElementList(depArrayElements)
        let leftSquareBracket = SyntaxFactory.makeLeftSquareBracketToken()
        let rightSquareBracket = SyntaxFactory.makeRightSquareBracketToken()
        let dependenciesValueExpr = SyntaxFactory.makeArrayExpr(leftSquare: leftSquareBracket, elements: dependencyArrayElementList, rightSquare: rightSquareBracket)
        let dependenciesArg = SyntaxFactory.makeFunctionCallArgument(label: dependencyLabel, colon: colon, expression: dependenciesValueExpr, trailingComma: nil)
        
        let args = [
            nameArg,
            dependenciesArg
        ]
        
        let argList = SyntaxFactory.makeFunctionCallArgumentList(args)
        let rightParen = SyntaxFactory.makeRightParenToken()
        
        return SyntaxFactory.makeFunctionCallExpr(calledExpression: calledExpr, leftParen: leftParen, argumentList: argList, rightParen: rightParen, trailingClosure: nil)
    }
}
