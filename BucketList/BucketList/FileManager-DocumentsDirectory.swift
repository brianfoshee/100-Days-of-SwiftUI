//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Brian Foshee on 14/5/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        //just use the first one, which should be the only one
        return paths[0]
    }
}
