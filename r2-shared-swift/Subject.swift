//
//  Subject.swift
//  r2-shared-swift
//
//  Created by Alexandre Camilleri on 2/17/17.
//
//  Copyright 2018 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

import Foundation

/// WebPub manifest spec
/// https://github.com/readium/webpub-manifest/blob/master/contexts/default/definitions.md#subjects
/// Epub 3.1
/// http://www.idpf.org/epub/31/spec/epub-packages.html#sec-opf-dcsubject
public class Subject: Encodable {
    public var name: String?
    /// The WebPubManifest elements
    public var sortAs: String?
    /// Epub 3.1 "scheme" (opf:authority)
    public var scheme: String?
    /// Epub 3.1 "code" (opf:term)
    public var code: String?
    /// Used to retrieve similar publications for the given subjects.
    public var links = [Link]()
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case name
        case sortAs
        case scheme
        case code
    }
    
}
