//
//  LinkTests.swift
//  r2-shared-swiftTests
//
//  Created by Mickaël Menu on 09.03.19.
//
//  Copyright 2019 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

import XCTest
@testable import R2Shared

class LinkTests: XCTestCase {
    
    func testParseMinimalJSON() {
        XCTAssertEqual(
            try? Link(json: ["href": "http://href"]),
            Link(href: "http://href")
        )
    }
    
    func testParseFullJSON() {
        XCTAssertEqual(
            try? Link(json: [
                "href": "http://href",
                "type": "application/pdf",
                "templated": true,
                "title": "Link Title",
                "rel": ["publication", "cover"],
                "properties": [
                    "orientation": "landscape"
                ],
                "height": 1024,
                "width": 768,
                "bitrate": 74.2,
                "duration": 45.6,
                "children": [
                    ["href": "http://child1"],
                    ["href": "http://child2"]
                ]
            ]),
            Link(
                href: "http://href",
                type: "application/pdf",
                templated: true,
                title: "Link Title",
                rels: ["publication", "cover"],
                properties: Properties(orientation: .landscape),
                height: 1024,
                width: 768,
                bitrate: 74.2,
                duration: 45.6,
                children: [
                    Link(href: "http://child1"),
                    Link(href: "http://child2")
                ]
            )
        )
    }
    
    func testParseInvalidJSON() {
        XCTAssertThrowsError(try Link(json: ""))
    }
    
    func testParseJSONRelAsSingleString() {
        XCTAssertEqual(
            try? Link(json: ["href": "a", "rel": "publication"]),
            Link(href: "a", rels: ["publication"])
        )
    }
    
    func testParseJSONTemplatedDefaultsToFalse() {
        XCTAssertFalse(try Link(json: ["href": "a"]).templated)
    }
    
    func testParseJSONTemplatedAsNull() {
        XCTAssertFalse(try Link(json: ["href": "a", "templated": NSNull()]).templated)
        XCTAssertFalse(try Link(json: ["href": "a", "templated": nil]).templated)
    }

    func testParseJSONRequiresHref() {
        XCTAssertThrowsError(try Link(json: ["type": "application/pdf"]))
    }
    
    func testParseJSONRequiresPositiveWidth() {
        XCTAssertEqual(
            try? Link(json: ["href": "a", "width": -20]),
            Link(href: "a")
        )
    }
    
    func testParseJSONRequiresPositiveHeight() {
        XCTAssertEqual(
            try? Link(json: ["href": "a", "height": -20]),
            Link(href: "a")
        )
    }
    
    func testParseJSONRequiresPositiveBitrate() {
        XCTAssertEqual(
            try? Link(json: ["href": "a", "bitrate": -20]),
            Link(href: "a")
        )
    }
    
    func testParseJSONRequiresPositiveDuration() {
        XCTAssertEqual(
            try? Link(json: ["href": "a", "duration": -20]),
            Link(href: "a")
        )
    }

    func testParseJSONArray() {
        XCTAssertEqual(
            [Link](json: [
                ["href": "http://child1"],
                ["href": "http://child2"]
            ]),
            [
                Link(href: "http://child1"),
                Link(href: "http://child2")
            ]
        )
    }
    
    func testParseJSONArrayWhenNil() {
        XCTAssertEqual(
            [Link](json: nil),
            []
        )
    }
    
    func testParseJSONArrayIgnoresInvalidLinks() {
        XCTAssertEqual(
            [Link](json: [
                ["title": "Title"],
                ["href": "http://child2"]
            ]),
            [
                Link(href: "http://child2")
            ]
        )
    }
    
    func testGetMinimalJSON() {
        AssertJSONEqual(
            Link(href: "http://href").json,
            [
                "href": "http://href",
                "templated": false
            ]
        )
    }
    
    func testGetFullJSON() {
        AssertJSONEqual(
            Link(
                href: "http://href",
                type: "application/pdf",
                templated: true,
                title: "Link Title",
                rels: ["publication", "cover"],
                properties: Properties(orientation: .landscape),
                height: 1024,
                width: 768,
                bitrate: 74.2,
                duration: 45.6,
                children: [
                    Link(href: "http://child1"),
                    Link(href: "http://child2")
                ]
            ).json,
            [
                "href": "http://href",
                "type": "application/pdf",
                "templated": true,
                "title": "Link Title",
                "rel": ["publication", "cover"],
                "properties": [
                    "orientation": "landscape"
                ],
                "height": 1024,
                "width": 768,
                "bitrate": 74.2,
                "duration": 45.6,
                "children": [
                    ["href": "http://child1", "templated": false],
                    ["href": "http://child2", "templated": false]
                ]
            ]
        )
    }
    
    func testGetJSONArray() {
        AssertJSONEqual(
            [
                Link(href: "http://child1"),
                Link(href: "http://child2")
            ].json,
            [
                ["href": "http://child1", "templated": false],
                ["href": "http://child2", "templated": false]
            ]
        )
    }

}
