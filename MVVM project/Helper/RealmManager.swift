//
//  RealmManager.swift
//  MVVM project
//
//  Created by 2B on 18/07/2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static func configureRealm() {
        let config = Realm.Configuration(
            // Set the current schema version
            schemaVersion: 1,

            // Set the block to perform schema migration if needed
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Add your migration code here
                    // For example, if you added a primary key property to 'MovieCashed':
                    migration.enumerateObjects(ofType: MovieCashed.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString
                    }
                }
            }
        )

        // Use the updated configuration when opening the Realm
        Realm.Configuration.defaultConfiguration = config
    }
}
