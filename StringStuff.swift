//
// StringStuff.swift
//
// Created by Ina Tolo
// Created on 2022-3-28
// Version 1.0
// Copyright (c) 2022 Ina Tolo. All rights reserved.
//
// The StringStuff program implements an application that
//  uses a function to alter the contents of a string based
// on the number characters present.
import Foundation

// uses recursion to reverse a string
func blowup(stringFromFile: String) -> String {
    // declaring variables
    var newString: String = ""
    var charInt: Int
    let tempArray: [Character] = Array(stringFromFile)

    // determines which character(s) in the array needs to be altered
    for cursor in 0..<tempArray.count - 1 {
        do {
            charInt = (Int) ((String) (tempArray[cursor])) ?? 0

            // checks if value cannot be casted
            if charInt != (Int) ((String) (tempArray[cursor])) {
                try catchString()
            }

            for numCount in 0..<charInt {
                newString += (String) (tempArray[cursor + 1])
            }

            if cursor == tempArray.count - 2 {
                do {
                   charInt = (Int) ((String) (tempArray[cursor + 1])) ?? 0

                    // checks if value cannot be casted
                    if charInt != (Int) ((String) (tempArray[cursor + 1])) {
                        try catchString()
                    }
                } catch {
                    newString += (String) (tempArray[cursor + 1])
                }
            }
        } catch {
            newString += (String) (tempArray[cursor])

            if cursor == tempArray.count - 2 {
                do {
                    charInt = (Int) ((String) (tempArray[cursor + 1])) ?? 0

                    // checks if value cannot be casted
                    if charInt != (Int) ((String) (tempArray[cursor + 1])) {
                        try catchString()
                    }

                } catch {
                    newString += (String) (tempArray[cursor + 1])
                }
            }
        }
    }

    if tempArray.count == 1 {
        do {
            charInt = (Int) ((String) (tempArray[0])) ?? 0

            // checks if value cannot be casted
            if charInt != (Int) ((String) (tempArray[0])) {
                try catchString()
            }

        } catch {
            newString += (String) (tempArray[0])
        }
    }
    return newString
}

// stores exception at runtime
enum MyError: Error {
    case runtimeError(String)
}

// function that throws exception
func catchString() throws {
    throw MyError.runtimeError("")
}

// declaring variables
let stringsLocation = "/home/runner/Assign-02-Swift/input.txt"
let text = ""
var arrayToString: String = ""
var blowupStringUser: String = ""
var alteredList: String = ""
// var loopCounter: Int = 0

print("The strings in the input file will be altered.")
print()

// reads file with strings into an array
let listOftrings: String = try String(contentsOfFile: stringsLocation)
let stringsArrayFile: [String] = listOftrings.components(separatedBy: "\n")

for loopCounter in 0..<stringsArrayFile.count {
    if stringsArrayFile[loopCounter].count == 0 {
        alteredList.append("\n")
        continue
    } 
    blowupStringUser = blowup(stringFromFile: stringsArrayFile[loopCounter])
    if loopCounter != stringsArrayFile.count - 1 {
        alteredList.append(blowupStringUser + "\n")
    } else {
        alteredList.append(blowupStringUser)
    }
    blowupStringUser = blowup(stringFromFile: stringsArrayFile[loopCounter])
}


// converts list of reversed strings to an array
let alteredStringsArray: [String] = alteredList.components(separatedBy: "\n")

// writes the new reversed strings to the output file
try text.write(to: URL(fileURLWithPath: "/home/runner/Assign-02-Swift/output.txt"),
    atomically: false, encoding: .utf8)

if let fileWriter = try? FileHandle(forUpdating:
    URL(fileURLWithPath: "/home/runner/Assign-02-Swift/output.txt")) {
    // adds each string to the output file
    for stringFormat in 0..<alteredStringsArray.count {
        if stringFormat != alteredStringsArray.count - 1 {
            arrayToString = alteredStringsArray[stringFormat] + "\n"
        } else {
            arrayToString = alteredStringsArray[stringFormat]
        }
        fileWriter.seekToEndOfFile()
        fileWriter.write(arrayToString.data(using: .utf8)!)
    }
    fileWriter.closeFile()
}
print("Done reversing. Check the output file.")
