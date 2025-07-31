//
//  PDFToDocxConfig.swift
//  MarkdownToDocxGlue
//
//  A glue library that provides seamless conversion between PDF styling configuration
//  and DOCX styling configuration, allowing users to use the same configuration
//  for both PDF and DOCX generation.
//
//  Created by Riyad Shauk on 7/30/25.
//

import Foundation
import MarkdownToDocx

// MARK: - PDF Styling Configuration

/// A configuration struct that matches the PDF styling configuration format
/// and can be seamlessly converted to DOCX configuration.
///
/// This struct is designed to be a 1:1 match with PDF configuration structs
/// used in other projects, making it easy to share configurations between
/// PDF and DOCX generation.
public struct PDFStylingConfig: Codable {
    // MARK: - Font settings
    /// Default font family (CSS-style font stack)
    public var defaultFont: String
    /// Default font size in points
    public var defaultFontSize: Int
    /// Monospace font family (CSS-style font stack)
    public var monoFont: String
    /// Monospace font size in points
    public var monoFontSize: Int
    
    // MARK: - Heading sizes
    /// H1 font size in points
    public var h1FontSize: Int
    /// H2 font size in points
    public var h2FontSize: Int
    /// H3 font size in points
    public var h3FontSize: Int
    
    // MARK: - Spacing
    /// Line height multiplier (e.g., 1.5 = 150% line height)
    public var lineHeight: Double
    /// Paragraph spacing in points
    public var paragraphSpacing: Int
    /// Heading spacing in points
    public var headingSpacing: Int
    /// List item spacing in points
    public var listItemSpacing: Int
    
    // MARK: - Margins (in points)
    /// Top margin in points
    public var topMargin: Double
    /// Bottom margin in points
    public var bottomMargin: Double
    /// Left margin in points
    public var leftMargin: Double
    /// Right margin in points
    public var rightMargin: Double
    
    // MARK: - Colors
    /// Text color in hex format (with or without #)
    public var textColor: String
    /// Heading color in hex format (with or without #)
    public var headingColor: String
    /// Link color in hex format (with or without #)
    public var linkColor: String
    /// Code background color in hex format (with or without #)
    public var codeBackgroundColor: String
    
    // MARK: - Page settings
    /// Page width in points
    public var pageWidth: Double
    /// Page height in points
    public var pageHeight: Double
    
    // MARK: - Initialization
    
    public init(
        defaultFont: String,
        defaultFontSize: Int,
        monoFont: String,
        monoFontSize: Int,
        h1FontSize: Int,
        h2FontSize: Int,
        h3FontSize: Int,
        lineHeight: Double,
        paragraphSpacing: Int,
        headingSpacing: Int,
        listItemSpacing: Int,
        topMargin: Double,
        bottomMargin: Double,
        leftMargin: Double,
        rightMargin: Double,
        textColor: String,
        headingColor: String,
        linkColor: String,
        codeBackgroundColor: String,
        pageWidth: Double,
        pageHeight: Double
    ) {
        self.defaultFont = defaultFont
        self.defaultFontSize = defaultFontSize
        self.monoFont = monoFont
        self.monoFontSize = monoFontSize
        self.h1FontSize = h1FontSize
        self.h2FontSize = h2FontSize
        self.h3FontSize = h3FontSize
        self.lineHeight = lineHeight
        self.paragraphSpacing = paragraphSpacing
        self.headingSpacing = headingSpacing
        self.listItemSpacing = listItemSpacing
        self.topMargin = topMargin
        self.bottomMargin = bottomMargin
        self.leftMargin = leftMargin
        self.rightMargin = rightMargin
        self.textColor = textColor
        self.headingColor = headingColor
        self.linkColor = linkColor
        self.codeBackgroundColor = codeBackgroundColor
        self.pageWidth = pageWidth
        self.pageHeight = pageHeight
    }
    
    // MARK: - Predefined Configurations
    
    /// Default configuration with standard settings
    public static let `default` = PDFStylingConfig(
        defaultFont: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        defaultFontSize: 12,
        monoFont: "'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace",
        monoFontSize: 11,
        h1FontSize: 18,
        h2FontSize: 14,
        h3FontSize: 12,
        lineHeight: 1.4,
        paragraphSpacing: 8,
        headingSpacing: 12,
        listItemSpacing: 4,
        topMargin: 36.0,      // 0.5 inches at 72 DPI
        bottomMargin: 36.0,
        leftMargin: 36.0,
        rightMargin: 36.0,
        textColor: "#333333",
        headingColor: "#000000",
        linkColor: "#0066cc",
        codeBackgroundColor: "#f5f5f5",
        pageWidth: 612.0,     // 8.5 inches at 72 DPI
        pageHeight: 792.0     // 11 inches at 72 DPI
    )
    
    /// Compact configuration for dense content
    public static let compact = PDFStylingConfig(
        defaultFont: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        defaultFontSize: 10,
        monoFont: "'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace",
        monoFontSize: 9,
        h1FontSize: 16,
        h2FontSize: 12,
        h3FontSize: 10,
        lineHeight: 1.2,
        paragraphSpacing: 6,
        headingSpacing: 8,
        listItemSpacing: 2,
        topMargin: 24.0,
        bottomMargin: 24.0,
        leftMargin: 24.0,
        rightMargin: 24.0,
        textColor: "#333333",
        headingColor: "#000000",
        linkColor: "#0066cc",
        codeBackgroundColor: "#f5f5f5",
        pageWidth: 612.0,
        pageHeight: 792.0
    )
    
    /// Large print configuration
    public static let largePrint = PDFStylingConfig(
        defaultFont: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        defaultFontSize: 14,
        monoFont: "'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace",
        monoFontSize: 13,
        h1FontSize: 22,
        h2FontSize: 18,
        h3FontSize: 16,
        lineHeight: 1.6,
        paragraphSpacing: 12,
        headingSpacing: 16,
        listItemSpacing: 6,
        topMargin: 48.0,
        bottomMargin: 48.0,
        leftMargin: 48.0,
        rightMargin: 48.0,
        textColor: "#333333",
        headingColor: "#000000",
        linkColor: "#0066cc",
        codeBackgroundColor: "#f5f5f5",
        pageWidth: 612.0,
        pageHeight: 792.0
    )
    
    /// Resume-optimized configuration (more compact, professional)
    public static let resumeOptimized = PDFStylingConfig(
        defaultFont: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        defaultFontSize: 11,
        monoFont: "'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace",
        monoFontSize: 10,
        h1FontSize: 16,
        h2FontSize: 13,
        h3FontSize: 11,
        lineHeight: 1.3,
        paragraphSpacing: 6,
        headingSpacing: 10,
        listItemSpacing: 3,
        topMargin: 30.0,
        bottomMargin: 30.0,
        leftMargin: 30.0,
        rightMargin: 30.0,
        textColor: "#333333",
        headingColor: "#000000",
        linkColor: "#0066cc",
        codeBackgroundColor: "#f5f5f5",
        pageWidth: 612.0,
        pageHeight: 792.0
    )
    
    /// Cover letter-optimized configuration (more readable, formal)
    public static let coverLetterOptimized = PDFStylingConfig(
        defaultFont: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        defaultFontSize: 12,
        monoFont: "'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace",
        monoFontSize: 11,
        h1FontSize: 18,
        h2FontSize: 14,
        h3FontSize: 12,
        lineHeight: 1.5,
        paragraphSpacing: 10,
        headingSpacing: 14,
        listItemSpacing: 5,
        topMargin: 40.0,
        bottomMargin: 40.0,
        leftMargin: 40.0,
        rightMargin: 40.0,
        textColor: "#333333",
        headingColor: "#000000",
        linkColor: "#0066cc",
        codeBackgroundColor: "#f5f5f5",
        pageWidth: 612.0,
        pageHeight: 792.0
    )
    
    // MARK: - Utility Methods
    
    /// Get page size as CGSize
    public var pageSize: CGSize {
        return CGSize(width: pageWidth, height: pageHeight)
    }
    
    /// Generate CSS from configuration (for PDF generation)
    public func generateCSS() -> String {
        return """
        body { 
            font-family: \(defaultFont);
            font-size: \(defaultFontSize)pt;
            line-height: \(lineHeight);
            margin: 0;
            padding: \(topMargin)pt \(rightMargin)pt \(bottomMargin)pt \(leftMargin)pt;
            color: \(textColor);
            background-color: transparent;
            word-wrap: break-word;
            overflow-wrap: break-word;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        h1 { 
            font-size: \(h1FontSize)pt; 
            font-weight: bold; 
            margin: 0 0 \(headingSpacing)pt 0;
            color: \(headingColor);
        }
        h2 { 
            font-size: \(h2FontSize)pt; 
            font-weight: bold; 
            margin: \(headingSpacing)pt 0 \(headingSpacing/2)pt 0;
            color: \(headingColor);
        }
        h3 { 
            font-size: \(h3FontSize)pt; 
            font-weight: bold; 
            margin: \(headingSpacing/2)pt 0 \(headingSpacing/3)pt 0;
            color: \(headingColor);
        }
        p { 
            margin: 0 0 \(paragraphSpacing)pt 0; 
        }
        ul, ol { 
            margin: 0 0 \(paragraphSpacing)pt 20pt; 
            padding: 0;
        }
        li { 
            margin: 0 0 \(listItemSpacing)pt 0; 
        }
        strong { 
            font-weight: bold; 
        }
        em { 
            font-style: italic; 
        }
        a { 
            color: \(linkColor); 
            text-decoration: none; 
        }
        code {
            font-family: \(monoFont);
            background-color: \(codeBackgroundColor);
            padding: 2px 4px;
            border-radius: 3px;
            font-size: \(monoFontSize)pt;
        }
        pre {
            background-color: \(codeBackgroundColor);
            padding: 12px;
            border-radius: 6px;
            overflow-x: auto;
            margin: \(paragraphSpacing)pt 0;
        }
        pre code {
            background-color: transparent;
            padding: 0;
        }
        html {
            height: 100%;
            overflow-x: auto;
            overflow-y: auto;
        }
        """
    }
}

// MARK: - DOCX Conversion

public extension PDFStylingConfig {
    
    /// Convert PDF configuration to DOCX configuration
    /// 
    /// This method handles all the unit conversions and assumptions needed
    /// to transform PDF configuration into DOCX configuration:
    /// 
    /// **Unit Conversions:**
    /// - Font sizes: PDF points → DOCX half-points (multiply by 2)
    /// - Margins: PDF points → DOCX twips (multiply by 20)
    /// - Spacing: PDF points → DOCX twips (multiply by 20)
    /// - Line height: PDF multiplier → DOCX twips (multiply by 240 for 12pt base)
    /// 
    /// **Font Handling:**
    /// - Extracts primary font from CSS font stack
    /// - Maps common system fonts to DOCX equivalents
    /// - Handles monospace fonts for code blocks
    /// 
    /// **Color Handling:**
    /// - Removes # prefix from hex colors
    /// - Preserves all color settings
    /// 
    /// **Page Size:**
    /// - Converts point dimensions to DOCX page size
    /// - Maps common sizes to predefined DOCX page sizes
    func toDocxConfig() -> UserFriendlyDocxStylingConfig {
        // Extract primary font from CSS font stack
        let primaryFont = extractPrimaryFont(from: defaultFont)
        let primaryMonoFont = extractPrimaryFont(from: monoFont)
        
        // Convert colors (remove # prefix)
        let cleanTextColor = textColor.replacingOccurrences(of: "#", with: "")
        let cleanHeadingColor = headingColor.replacingOccurrences(of: "#", with: "")
        let cleanLinkColor = linkColor.replacingOccurrences(of: "#", with: "")
        let cleanCodeBackgroundColor = codeBackgroundColor.replacingOccurrences(of: "#", with: "")
        
        // Determine page size
        let docxPageSize = determinePageSize(width: pageWidth, height: pageHeight)
        
        return UserFriendlyDocxStylingConfig(
            pageSize: docxPageSize,
            pageMargins: UserFriendlyPageMargins(
                top: .points(topMargin),
                right: .points(rightMargin),
                bottom: .points(bottomMargin),
                left: .points(leftMargin)
            ),
            defaultFont: UserFriendlyFontConfig(
                name: primaryFont,
                size: .points(Double(defaultFontSize)),
                color: cleanTextColor
            ),
            lineSpacing: LineSpacing(
                type: .multiple,
                value: Int(lineHeight * 240) // Convert to twips (12pt * 20 * lineHeight)
            ),
            headings: HeadingStyles(
                h1: HeadingStyle(
                    level: 1,
                    font: FontConfig(
                        name: primaryFont,
                        size: h1FontSize * 2, // Convert to half-points
                        color: cleanHeadingColor
                    ),
                    spacing: Spacing(
                        before: headingSpacing * 20, // Convert to twips
                        after: headingSpacing * 20
                    )
                ),
                h2: HeadingStyle(
                    level: 2,
                    font: FontConfig(
                        name: primaryFont,
                        size: h2FontSize * 2,
                        color: cleanHeadingColor
                    ),
                    spacing: Spacing(
                        before: headingSpacing * 20,
                        after: headingSpacing * 20
                    )
                ),
                h3: HeadingStyle(
                    level: 3,
                    font: FontConfig(
                        name: primaryFont,
                        size: h3FontSize * 2,
                        color: cleanHeadingColor
                    ),
                    spacing: Spacing(
                        before: headingSpacing * 20,
                        after: headingSpacing * 20
                    )
                )
            ),
            paragraphs: ParagraphStyles(
                spacing: Spacing(
                    before: paragraphSpacing * 20, // Convert to twips
                    after: paragraphSpacing * 20
                )
            ),
            codeBlocks: CodeBlockStyles(
                font: FontConfig(
                    name: primaryMonoFont,
                    size: monoFontSize * 2, // Convert to half-points
                    color: cleanTextColor
                ),
                background: cleanCodeBackgroundColor
            ),
            lists: ListStyles(
                indentation: listItemSpacing * 20 // Convert to twips
            ),
            linkColor: cleanLinkColor
        )
    }
    
    /// Create a DOCX converter with this configuration
    func createDocxConverter() -> MarkdownToDocxConverter {
        return MarkdownToDocxConverter(userFriendlyConfig: toDocxConfig())
    }
}

// MARK: - Private Helper Methods

private extension PDFStylingConfig {
    
    /// Extract the primary font from a CSS font stack
    func extractPrimaryFont(from fontStack: String) -> String {
        // Remove quotes and split by comma
        let fonts = fontStack
            .replacingOccurrences(of: "'", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        // Return the first font, or a default if empty
        return fonts.first ?? "Calibri"
    }
    
    /// Determine the appropriate DOCX page size based on dimensions
    func determinePageSize(width: Double, height: Double) -> PageSize {
        // Common page sizes in points
        let letterSize = (width: 612.0, height: 792.0)
        let legalSize = (width: 612.0, height: 1008.0)
        let a4Size = (width: 595.0, height: 842.0)
        let a3Size = (width: 842.0, height: 1191.0)
        let a5Size = (width: 420.0, height: 595.0)
        let executiveSize = (width: 522.0, height: 756.0)
        let tabloidSize = (width: 792.0, height: 1224.0)
        
        // Check for exact matches first
        if abs(width - letterSize.width) < 1 && abs(height - letterSize.height) < 1 {
            return .letter
        } else if abs(width - legalSize.width) < 1 && abs(height - legalSize.height) < 1 {
            return .legal
        } else if abs(width - a4Size.width) < 1 && abs(height - a4Size.height) < 1 {
            return .a4
        } else if abs(width - a3Size.width) < 1 && abs(height - a3Size.height) < 1 {
            return .a3
        } else if abs(width - a5Size.width) < 1 && abs(height - a5Size.height) < 1 {
            return .a5
        } else if abs(width - executiveSize.width) < 1 && abs(height - executiveSize.height) < 1 {
            return .executive
        } else if abs(width - tabloidSize.width) < 1 && abs(height - tabloidSize.height) < 1 {
            return .tabloid
        }
        
        // If no exact match, create a custom page size
        return PageSize(
            width: .points(width),
            height: .points(height)
        )
    }
} 