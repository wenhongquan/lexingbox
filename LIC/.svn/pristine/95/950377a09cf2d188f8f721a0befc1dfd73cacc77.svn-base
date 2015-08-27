//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let i = 03.0


var a:CLong = 54

var b = Int(a)

var c = Double(a) / (Double(b)*0.1)

var d = Double(a) + Double(b)

var f = Int((1000585/1000.0)*10/10)


let strs = String(format:"%.2f",i)

println("\(strs)")  //输出为03


var strss = "\u672a"


let string = "[ {\"name\": \"John\", \"age\": 21}, {\"name\": \"Bob\", \"age\": 35} ]"




func JSONParseArray(jsonString: String) -> [AnyObject] {
    if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
        if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
            return array
        }
    }
    return [AnyObject]()
}

println(JSONParseArray(strss))

for elem: AnyObject in JSONParseArray(strss) {
//    let name = elem["gpsStatus"] as! String
    let age = elem["id"] as! Int
//    println("Name: \(name), Age: \(age)")
}
