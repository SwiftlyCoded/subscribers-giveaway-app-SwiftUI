//
//  Participants.swift
//  results
//
//  Created by Alex on 26/02/2021.
//
import Foundation

func readFile() -> [String.SubSequence]{
    
    let fileURLProject = Bundle.main.path(forResource: "participants", ofType: "txt")
    var readStringProject = ""
    
    do {
        readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
    } catch let error as NSError {
        print("Failed reading from URL: \(fileURLProject ?? ""), Error: " + error.localizedDescription)
    }
    
    let result = readStringProject.split(separator: "\n")
    
    print(result)
    
    return result
    
}
