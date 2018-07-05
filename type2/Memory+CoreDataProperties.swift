//
//  Memory+CoreDataProperties.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/07/03.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//
//

import Foundation
import CoreData


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var best: String?
    @NSManaged public var date: String?
    @NSManaged public var fes: String?
    @NSManaged public var id: String?
    @NSManaged public var impression: String?
    @NSManaged public var picture: String?

}
