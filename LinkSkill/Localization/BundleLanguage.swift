//
//  BundleLanguage.swift
//  LinkSkill
//
//  Created by Rohit SIngh Dhakad on 13/05/26.
//

//
//  Bundle+Language.swift
//

import Foundation
import ObjectiveC.runtime

private var bundleKey: UInt8 = 0

final class BundleEx: Bundle, @unchecked Sendable {

    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {

        if let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle {
            return bundle.localizedString(forKey: key,
                                          value: value,
                                          table: tableName)
        }

        return super.localizedString(forKey: key,
                                     value: value,
                                     table: tableName)
    }
}

extension Bundle {

    static func setLanguage(_ language: String) {

        object_setClass(Bundle.main, BundleEx.self)

        guard let path = Bundle.main.path(forResource: language,
                                          ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return
        }

        objc_setAssociatedObject(Bundle.main,
                                 &bundleKey,
                                 bundle,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
