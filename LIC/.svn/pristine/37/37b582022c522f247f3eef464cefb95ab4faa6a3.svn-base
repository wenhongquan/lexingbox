//
//  rangString.swift
//  LIC
//
//  Created by 温红权 on 15/3/17.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

extension String
{
    
    // Works in Xcode but not Playgrounds because of a bug with .insert()
    
    mutating func insertString(string:String,ind:Int) {
        var insertIndex = advance(self.startIndex, ind, self.endIndex)
        for c in string {
            self.insert(c, atIndex: insertIndex)
            insertIndex = advance(insertIndex, 1)
        }
    }
    
    // new replace method using replaceRange (replaces all instances of string)
    mutating func replace(string:String, replacement:String) {
        
        
        let ranges = self.rangesOfString(string)
        // if the string isn't found return unchanged string
        
        
        for r in ranges {
            self.replaceRange(r, with: replacement)
        }
    }
    
    // Swift pure containsString
    
    func containsString(findStr:String) -> Bool {
        var arr = [Range<String.Index>]()
        var startInd = self.startIndex
        var i = 0
        // test first of all whether the string is likely to appear at all
        if contains(self, first(findStr)!) {
            startInd = find(self,first(findStr)!)!
        }
        else {
            return false
        }
        // set starting point for search based on the finding of the first character
        i = distance(self.startIndex, startInd)
        while i<=countElements(self)-countElements(findStr) {
            if self[advance(self.startIndex, i)..<advance(self.startIndex, i+countElements(findStr))] == findStr {
                arr.append(Range(start:advance(self.startIndex, i),end:advance(self.startIndex, i+countElements(findStr))))
                return true
            }
            i++
        }
        return false
    }
    
    
    // pure Swift - removeAtIndex no longer required, since the addition of following methods to String type
    // mutating func removeAtIndex(i: String.Index) -> Character
    // mutating func removeRange(subRange: Range<String.Index>)
    // mutating func removeAll(keepCapacity: Bool = default)
    
    
    // insert() method written in pure Swift, overloads the new String type method of the same name
    
    func insert(string:String,ind:Int) -> String {
        
        var insertIndex = advance(self.startIndex, ind, self.endIndex)
        var returnString = toString(self)
        for c in string {
            returnString.insert(c, atIndex: insertIndex)
            insertIndex = advance(insertIndex, 1)
        }
        return returnString
    }
    
    // rangesOfString: written in pure Swift (no Cocoa)
    func rangesOfString(findStr:String) -> [Range<String.Index>] {
        var arr = [Range<String.Index>]()
        var startInd = self.startIndex
        // check first that the first character of search string exists
        if contains(self, first(findStr)!) {
            // if so set this as the place to start searching
            startInd = find(self,first(findStr)!)!
        }
        else {
            // if not return empty array
            return arr
        }
        var i = distance(self.startIndex, startInd)
        while i<=countElements(self)-countElements(findStr) {
            if self[advance(self.startIndex, i)..<advance(self.startIndex, i+countElements(findStr))] == findStr {
                arr.append(Range(start:advance(self.startIndex, i),end:advance(self.startIndex, i+countElements(findStr))))
                i = i+countElements(findStr)-1
                // check again for first occurrence of character (this reduces number of times loop will run
                if contains(self[advance(self.startIndex, i)..<self.endIndex], first(findStr)!) {
                    // if so set this as the place to start searching
                    i = distance(self.startIndex,find(self[advance(self.startIndex, i)..<self.endIndex],first(findStr)!)!) + i
                    countElements(findStr)
                }
                else {
                    return arr
                }
                
            }
            i++
        }
        return arr
    }
    
    
    func stringByReplacingOccurrencesOfString(string:String, replacement:String) -> String {
        
        // get ranges first using rangesOfString: method, then glue together the string using ranges of existing string and old string
        
        let ranges = self.rangesOfString(string)
        // if the string isn't found return unchanged string
        if ranges.isEmpty {
            return self
        }
        // using toString to make a copy so that self isn't altered
        var newString = toString(self)
        for r in ranges {
            newString.replaceRange(r, with: replacement)
        }
        return newString
    }
    
    // Added String splitting methods that return arrays (Pure Swift)
    func splitStringByCharacters() -> [Character] {
        return map(self){return $0}
    }
    
    func splitStringByLines() -> [String] {
        return split(self, {contains("\u{2028}\n\r", $0)
            }, allowEmptySlices: false)
    }
    
    func splitStringByWords() -> [String] {
        return split(self, {contains(" .,!:;()[]{}<>?\"'\u{2028}\u{2029}\n\r", $0)}, allowEmptySlices: false)
    }
    
    func splitStringByParagraphs() -> [String] {
        return split(self, {contains("\u{2029}\n\r", $0)
            }, allowEmptySlices: false)
        
    }
    
    func splitStringBySentences() -> [String] {
        let arr:[Character] = ["\u{2026}",".","?", "!"]
        var startInd = self.startIndex
        var strArr = [String]()
        for b in enumerate(self) {
            for a in arr {
                if a == b.element {
                    
                    var endInd = advance(self.startIndex,b.index,self.endIndex)
                    
                    //TODO: add method to allow for multiple punctuation at end of sentence, e.g. ??? or !!!
                    
                    var str = self[startInd...endInd]
                    
                    // removes initial spaces and returns from sentence
                    if contains(" \u{2028}\u{2029}\n\r",first(str)!)  {
                        str = dropFirst(str)
                    }
                    strArr.append(str)
                    startInd = advance(endInd,1,self.endIndex)
                    
                }
                
            }
            
        }
        return strArr
        
    }
    
    // added regexMatchesInString to remove reliance on NSRegularExpression
    func regexMatchesInString(regexString:String) -> [String] {
        var arr = [String]()
        var rang = Range(start: self.startIndex, end: self.endIndex)
        var foundRange:Range<String.Index>?
        
        do
        {
            foundRange = self.rangeOfString(regexString, options: NSStringCompareOptions.RegularExpressionSearch, range: rang, locale: nil)
            
            if let a = foundRange {
                arr.append(self.substringWithRange(a))
                rang.startIndex = a.endIndex
            }
        }
            while foundRange != nil
        return arr
    }
    var length: Int {
        get {
            return countElements(self)
        }
    }
    
    
    
    
    
    subscript (i: Int) -> Character
        {
        get {
            let index = advance(startIndex, i)
            return self[index]
        }
    }
    
    subscript (r: Range<Int>) -> String
        {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            let endIndex = advance(self.startIndex, r.endIndex - 1)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
    func subString(startIndex: Int, length: Int) -> String
    {
        var start = advance(self.startIndex, startIndex)
        var end = advance(self.startIndex, startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
    func indexOf(target: String) -> Int
    {
        var range = self.rangeOfString(target)
        if let range = range {
            return distance(self.startIndex, range.startIndex)
        } else {
            return -1
        }
    }
    
    func indexOf(target: String, startIndex: Int) -> Int
    {
        var startRange = advance(self.startIndex, startIndex)
        
        var range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        
        if let range = range {
            return distance(self.startIndex, range.startIndex)
        } else {
            return -1
        }
    }
    
    func lastIndexOf(target: String) -> Int
    {
        var index = -1
        var stepIndex = self.indexOf(target)
        while stepIndex > -1
        {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    // Updated isMatch to remove reliance on NSRegularExpression
    func isMatch(regex: String, options: NSStringCompareOptions?) -> Bool
    {
        
        let match = self.rangeOfString(regex, options: options ?? nil, range: Range(start: self.startIndex, end: self.endIndex), locale: nil)
        return match != nil ? true : false
    }
    
    // getMatches updated to remove reliance on NSRegularExpression
    func getMatches(regex: String, options: NSStringCompareOptions?) -> [Range<String.Index>] {
        var arr = [Range<String.Index>]()
        var rang = Range(start: self.startIndex, end: self.endIndex)
        var foundRange:Range<String.Index>?
        
        do
        {
            foundRange = self.rangeOfString(regex, options: options ?? nil, range: rang, locale: nil)
            
            if let a = foundRange {
                arr.append(a)
                rang.startIndex = foundRange!.endIndex
            }
        }
            while foundRange != nil
        return arr
    }
    
    private var vowels: [String]
        {
            
            return ["a", "e", "i", "o", "u"]
            
    }
    
    private var consonants: [String]
        {
            
            return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
            
    }
    
    func pluralize(count: Int) -> String
    {
        if count == 1 {
            return self
        } else {
            var lastChar = self.subString(self.length - 1, length: 1)
            var secondToLastChar = self.subString(self.length - 2, length: 1)
            var prefix = "", suffix = ""
            
            if lastChar.lowercaseString == "y" && vowels.filter({x in x == secondToLastChar}).count == 0 {
                prefix = self[0...self.length - 1]
                suffix = "ies"
            } else if lastChar.lowercaseString == "s" || (lastChar.lowercaseString == "o" && consonants.filter({x in x == secondToLastChar}).count > 0) {
                prefix = self[0...self.length]
                suffix = "es"
            } else {
                prefix = self[0...self.length]
                suffix = "s"
            }
            
            return prefix + (lastChar != lastChar.uppercaseString ? suffix : suffix.uppercaseString)
        }
    }
    
    // for fun, not sure whether this has a practical application
    func removeDuplicates(array:String) -> String {
        var arr = array
        var indArr = [Int]()
        var tempArr = arr
        var i = 0
        for a in arr {
            
            if contains(prefix(arr, i), a) {
                indArr.append(i)
            }
            
            i++
        }
        
        
        var ind = 0
        for i in indArr {
            arr.removeAtIndex(i-ind)
            ind++
        }
        return arr
    }
}