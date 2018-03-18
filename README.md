# Manifestor
This is a prototype for my Google Summer of Code proposal to the Swift Organization.
This is meant as a proof-of-concept to show how one might edit the Package.swift file mechanically using SwiftSyntax/libSyntax. Currently, it only adds targets to an existing Package.swift file and then prints the new file without writing the changes back to disk.

Usage:

I built the project using the instructions at the bottom of this page: https://github.com/apple/swift/blob/master/lib/Syntax/README.md

After building the project in Xcode, run the program from the command line with the Package.swift manifest file as the only argument.

`
./Manifestor Package.swift
`

Insights:
- This program does not follow the format of the current targets (i.e. will not use newlines or other trivia that other targets may be using). This brings up the question of formatting the Package.swift file. Should there be a standard for this or should it try to respect the current format of the file?
- SwiftSyntax/libSyntax offers a lot of options while creating syntax from the ground up. However, this at times feels like too much flexibility at the expense of being verbose, at least for the purpose of creating syntax. I think a part of this project should be to create a library that simplifies SwiftSyntax for the sole purpose of creating simple pieces of syntax. This would save a lot of time in the longterm for this project.
