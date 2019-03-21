//
//  Publication+Deprecated.swift
//  r2-shared-swift
//
//  Created by Mickaël Menu on 13.03.19.
//
//  Copyright 2019 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

import Foundation


extension Publication {
    
    @available(*, deprecated, renamed: "init(metadata:)")
    public convenience init() {
        self.init(metadata: Metadata(title: ""))
    }
    
}

@available(*, deprecated, renamed: "LocalizedString")
public typealias MultilangString = LocalizedString

extension LocalizedString {
    
    @available(*, deprecated, message: "Get with the property `string`, or set using `LocalizedString.nonlocalized(string)`")
    public var singleString: String? {
        get { return string.isEmpty ? nil : string }
        set { self = .nonlocalized(newValue ?? "") }
    }
    
    @available(*, deprecated, message: "Get with `string(forLanguageCode:)`, or set using `LocalizedString.localized(strings)`")
    public var multiString: [String: String] {
        get {
            guard case .localized(let strings) = self else {
                return [:]
            }
            return strings
        }
        set {
            guard !newValue.isEmpty else {
                return
            }
            self = .localized(newValue)
        }
    }
    
    @available(*, deprecated, renamed: "LocalizedString.localized")
    public init() {
        self = .localized([:])
    }

}


extension Metadata {
    
    @available(*, deprecated, renamed: "type")
    public var rdfType: String? {
        get { return type }
        set { type = newValue }
    }
    
    @available(*, deprecated, renamed: "localizedTitle")
    public var multilangTitle: LocalizedString {
        get { return localizedTitle }
        set { localizedTitle = newValue }
    }
    
    @available(*, deprecated, renamed: "localizedSubtitle")
    public var multilangSubtitle: LocalizedString? {
        get { return localizedSubtitle }
        set { localizedSubtitle = newValue }
    }
    
    @available(*, unavailable, message: "Not used anymore, you can store the rights in `otherMetadata[\"rights\"]` if necessary")
    public var rights: String? { get { return nil } set {} }
    
    @available(*, unavailable, message: "Not used anymore, you can store the source in `otherMetadata[\"source\"]` if necessary")
    public var source: String? { get { return nil } set {} }
    
    @available(*, deprecated, renamed: "init(title:)")
    public init() {
        self.init(title: "")
    }
    
    @available(*, deprecated, message: "Use `localizedTitle.string(forLanguageCode:)` instead")
    public func titleForLang(_ lang: String) -> String? {
        return localizedTitle.string(forLanguageCode: lang)
    }
    
    @available(*, deprecated, message: "Use `localizedSubtitle.string(forLanguageCode:)` instead")
    public func subtitleForLang(_ lang: String) -> String? {
        return localizedSubtitle?.string(forLanguageCode: lang)
    }
    
    @available(*, deprecated, renamed: "init(json:)")
    public static func parse(metadataDict: [String: Any]) throws -> Metadata {
        return try Metadata(json: metadataDict, normalizeHref: { $0 })
    }
    
}


extension Contributor {
    
    @available(*, deprecated, renamed: "localizedName")
    public var multilangName: LocalizedString {
        get { return localizedName }
        set { localizedName = newValue }
    }
    
    @available(*, deprecated, renamed: "init(name:)")
    public init() {
        self.init(name: "")
    }
    
    @available(*, deprecated, renamed: "init(json:)")
    public static func parse(_ cDict: [String: Any]) throws -> Contributor {
        return try Contributor(json: cDict, normalizeHref: { $0 })
    }
    
    @available(*, deprecated, message: "Use `[Contributor](json:)` instead")
    public static func parse(contributors: Any) throws -> [Contributor] {
        return [Contributor](json: contributors, normalizeHref: { $0 })
    }
    
}


extension Subject {
    
    @available(*, deprecated, renamed: "init(name:)")
    public init() {
        self.init(name: "")
    }
    
}


extension Link {
    
    @available(*, deprecated, renamed: "type")
    public var typeLink: String? { get { return type } set { type = newValue } }
    
    @available(*, deprecated, renamed: "rels")
    public var rel: [String] { get { return rels } set { rels = newValue } }
    
    @available(*, deprecated, renamed: "href")
    public var absoluteHref: String? { get { return href } set { href = newValue ?? href } }
    
    @available(*, deprecated, renamed: "init(href:)")
    public convenience init() {
        self.init(href: "")
    }
    
    @available(*, deprecated, renamed: "init(json:)")
    static public func parse(linkDict: [String: Any]) throws -> Link {
        return try Link(json: linkDict, normalizeHref: { $0 })
    }
    
}


@available(*, deprecated, renamed: "OPDSPrice")
public typealias Price = OPDSPrice


@available(*, deprecated, renamed: "OPDSAcquisition")
public typealias IndirectAcquisition = OPDSAcquisition

extension OPDSAcquisition {

    @available(*, deprecated, renamed: "type")
    public var typeAcquisition: String { get { return type } set { type = newValue } }
    
    @available(*, deprecated, renamed: "children")
    public var child: [OPDSAcquisition] { get { return children } set { children = child } }
    
}
