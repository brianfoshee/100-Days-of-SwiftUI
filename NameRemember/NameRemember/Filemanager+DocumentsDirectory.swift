//
//  Filemanager+DocumentsDirectory.swift
//  NameRemember
//
//  Created by Brian Foshee on 20/5/22.
//

import Foundation

extension FileManager {
    static var userDocumentsDirectory: URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        //just use the first one, which should be the only one
        return paths[0]
    }
}
