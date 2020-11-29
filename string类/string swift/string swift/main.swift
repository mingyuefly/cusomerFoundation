//
//  main.swift
//  string swift
//
//  Created by guomingyue on 2020/11/6.
//

/*
有时候我们会有需求从一个字符串中截取其他的字符串,根据情况的不同,我们来分析几种方法~~

一. 固定长度字符串中截取固定位置长度的字符串

// 这是比较简单的一种情况:比如截取手机号的后4位
 let phoneNum = "18515383061"
 var suffixNum:String?
 // 从倒数第四位开始截取,截取到最后
 suffixNum = phoneNum.substringFromIndex(phoneNum.endIndex.advancedBy(-4))
 // 从开头截取到第三位,获取手机号前3位
 let prefixNum = phoneNum.substringToIndex(phoneNum.startIndex.advancedBy(3))
 // 截取区间内字符串
 suffixNum = phoneNum.substringWithRange(phoneNum.endIndex.advancedBy(-4)..<phoneNum.endIndex)
二. 不固定长度的字符串,但是有分隔符

 //例如获取日期中的年,月,日
 // 分割符可以是任意的字符,一般为'/','_','空格',或者是特殊的字符.
 let timeStr = "2013/10/26"
 let timeArr = timeStr.componentsSeparatedByString("/")
 print(timeArr)
三. 不固定长度的字符串,取特殊规则下的字符串

 // 如下所示,我们想要截取第一个中括号里面的字符串
 // 假设这个字符串是服务器返回的,长度不定,中括号的位置也不定,先后通过简单的截取就比较困难了
 // 这个时候就要用到**正则表达式**,相信大家知道,但如何在Swift中利用正则表达式来筛选值呢,我们来分析一下
 // rangOfString本来是用来收索文中的字符串的,但是可以选择模式.这里选择(.RegularExpressionSearch)也就是正则的搜索
 // 但是OC和Swift中都只有这一种收索方法,只有Search,没有其他的,相比其他的语言(Python,PHP)弱太多了

 // 单纯匹配中括号里的字正则想必大家都会写 "\\[.*\\]",但是有一个问题就是收索的内容是'[thing] jflsdfs [do]',这显然不是我们想要的
 // 这就要收到正则的贪婪模式了,默认它尽可能多的匹配符合要求的字符串,而我们想让他满足最精巧的那个,就需要加上一个?号,就是这个样子"\\[.*?\\]",这样搜索到的就是'[thing]'
 // 你发现这还不是我们想要的,为什么要带上'['和']'呢,但是没办法,这是你的检索条件啊
 // 但是什么也难不倒正则,正则当中有 零宽断言,<零宽度正预测先行断言(?=exp)> 断言自身出现的位置的后面能匹配表达式exp,
 // <零宽度正回顾后发断言(?<=exp)>，它断言自身出现的位置的前面能匹配表达式exp,最终我们的表达式是"(?<=\\[).*?(?=\\])"

 let string = "I Want to Do some [thing] jflsdfs [do]"
 if let result = string.rangeOfString("(?<=\\[).*?(?=\\])", options: .RegularExpressionSearch, range:string.startIndex..<string.endIndex, locale: nil)  {
         print(string.substringWithRange(result))
}
*/

import Foundation

print("Hello, World!")

var str = "Hello, playground"
print(str)

let nstring = "美国,日本,澳大利亚,中国,俄罗斯,中国龙,阿萨德中国";
//定义正则表达式
let pattern = "\\b中国\\b";
let regular = try! NSRegularExpression(pattern: pattern, options:.caseInsensitive)
let results = regular.matches(in: nstring, options: .reportProgress, range: NSMakeRange(0, nstring.count))
//输出截取结果
print("符合的结果有\(results.count)个")
for result in results {
    print((nstring as NSString).substring(with: result.range))
}

// 提取表情符号
var string1 = "I Want to Do some [thing] jflsdfs [do] hello"
//let pattern1 = "(?<=\\[).*?(?=\\])"
let pattern1 = "\\[.*?\\]"
let regular1 = try! NSRegularExpression(pattern: pattern1, options:.caseInsensitive)
let results1 = regular1.matches(in: string1, options: .reportProgress, range: NSMakeRange(0, string1.count))
print("符合的结果有\(results1.count)个")
var tmpString = ""
var tmpString1 = String(string1)
var tmpString2 = string1
var ranges:[NSRange] = [NSRange]()
for result in results1 {
    print((string1 as NSString).substring(with: result.range))
    let range = result.range
    print(range)
    ranges.append(range)
}

var emojStrings = [String]()
print("[] ranges:")
for range in ranges {
    print(range)
    let emojString = (string1 as NSString).substring(with: range)
    print(emojString)
    emojStrings.append(emojString)
}
var ranges1:[NSRange] = [NSRange]()
var tmpRange:NSRange?
for i in 0..<results1.count {
    let range = results1[i].range
    if i == 0 {
        if range.location != 0 {
            ranges1.append(NSRange(location: 0, length: range.location))
        }
    } else {
        if (range.location - ((tmpRange?.location ?? 0) + (tmpRange?.length ?? 0))) > 1 {
            ranges1.append(NSRange(location: (tmpRange?.location ?? 0) + (tmpRange?.length ?? 0), length: range.location - ((tmpRange?.location ?? 0) + (tmpRange?.length ?? 0))))
        }
    }
    tmpRange = range
}

if (string1.count - ((tmpRange?.location ?? 0) + (tmpRange?.length ?? 0))) > 0 {
    ranges1.append(NSRange(location: (tmpRange?.location ?? 0) + (tmpRange?.length ?? 0), length: string1.count - ((tmpRange?.location ?? 0) + (tmpRange?.length ?? 0))))
}

var strings:[String] = [String]()
print("str ranges:")
for range in ranges1 {
    print(range)
    let string = (string1 as NSString).substring(with: range)
    print(string)
    strings.append(string)
}

print(strings)

for i in 0..<emojStrings.count {
    emojStrings[i] += "ss"
}

var resultString = ""
for i in 0..<emojStrings.count {
    resultString += strings[i]
    resultString += emojStrings[i]
}

if strings.count > emojStrings.count {
    resultString += strings[strings.count - 1]
}

print(resultString)
print(string1)

var string3 = resultString
for emojCode in emojStrings {
    string3 = string3.replacingOccurrences(of: emojCode, with: "H")
}

print(string3)




