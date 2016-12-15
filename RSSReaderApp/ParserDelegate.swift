//
//  ParserDelegate.swift
//  RSSReaderApp
//
//  Created by 川崎 隆介 on 2015/12/19.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import Foundation

protocol ParserDelegate : class{
    func parserDidParse(
        _ entries:Array<[String:AnyObject]>)
}
