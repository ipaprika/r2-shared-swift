//
//  Rendition.swift
//  r2-shared-swift
//
//  Created by Alexandre Camilleri on 2/17/17.
//
//  Copyright 2018 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

import Foundation

/// The rendition layout property of an EPUB publication
///
/// - Reflowable: Apply dynamic pagination when rendering.
/// - Fixed: Fixed layout.
public enum RenditionLayout: String, Encodable {
    case reflowable = "reflowable"
    case fixed = "pre-paginated"
}

/// The rendition flow property of an EPUB publication.
///
/// - Paginated: Indicates the Author preference is to dynamically paginate content overflow.
/// - Continuous:Indicates the Author preference is to provide a scrolled view
///              for overflow content, and that consecutive readingOrder items with this
///              property are to be rendered as a continuous scroll.
/// - Document: Indicates the Author preference is to provide a scrolled view for
///             overflow content, and each readingOrder item with this property is to
///             be rendered as separate scrollable document.
/// - Fixed:
public enum RenditionFlow: String, Encodable {
    case paginated = "paginated"
    case continuous = "continuous"
    case document = "document"
    case fixed = "fixed" // Is that correct?
}

/// The rendition orientation property of an EPUB publication.
///
/// - Auto: Specifies that the Reading System can determine the orientation to
///         rendered the readingOrder item in.
/// - Landscape: Specifies that the given readingOrder item is to be rendered in
///              landscape orientation.
/// - Portrait: Specifies that the given readingOrder item is to be rendered in portrait
///             orientation.
public enum RenditionOrientation: String, Encodable {
    case auto = "auto"
    case landscape = "landscape"
    case portrait = "portrait"
}

/// The rendition spread property of an EPUB publication.
///
/// - auto: Specifies the Reading System can determine when to render a synthetic
///         spread for the readingOrder item.
/// - landscape: Specifies the Reading System should render a synthetic spread 
///              for the readingOrder item only when in landscape orientation.
/// - portrait: The spread-portrait property is deprecated in [EPUB3]. Refer to 
///             its definition in [Publications301] for more information.
/// - both: Specifies the Reading System should render a synthetic spread for the
///         readingOrder item in both portrait and landscape orientations.
/// - none: Specifies the Reading System should not render a synthetic spread 
///         for the readingOrder item.
public enum RenditionSpread: String, Encodable {
    case auto = "auto"
    case landscape = "landscape"
    case portrait = "portrait"
    case both = "both"
    case none = "none"
}

/// The information relative to the rendering of the publication.
/// It includes if it's reflowable or pre-paginated, the orientation, the synthetic spread
/// behaviour and if the content flow should be scrolled, continuous or paginated.
public class Rendition: Encodable {
    /// The rendition layout (reflowable or fixed).
    public var layout: RenditionLayout?
    /// The rendition flow.
    public var flow: RenditionFlow?
    /// The rendition orientation.
    public var orientation: RenditionOrientation?
    /// The synthetic spread behaviour.
    public var spread: RenditionSpread?
    /// The rendering viewport size.
    public var viewport: String?

    public init() {}

    public func isEmpty() -> Bool {
        guard layout != nil || flow != nil
            || orientation != nil || spread != nil
            || viewport != nil else
        {
            return true
        }
        return false
    }
    
    enum CodingKeys: String, CodingKey {
        case layout
        case flow
        case orientation
        case spread
        case viewport
    }
    
}
