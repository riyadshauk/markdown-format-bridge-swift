import XCTest
import ZIPFoundation
import MarkdownToDocx
@testable import MarkdownFormatBridge

final class PDFToDocxConfig: XCTestCase {
    
    func testPredefinedConfigurations() throws {
        // Test that all predefined configurations can be created
        let configs = [
            PDFStylingConfig.default,
            PDFStylingConfig.compact,
            PDFStylingConfig.largePrint,
            PDFStylingConfig.resumeOptimized,
            PDFStylingConfig.coverLetterOptimized
        ]
        
        for config in configs {
            // Test that conversion works
            let docxConfig = config.toDocxConfig()
            XCTAssertNotNil(docxConfig)
            
            // Test that converter can be created
            let converter = config.createDocxConverter()
            XCTAssertNotNil(converter)
        }
    }
    
    func testUnitConversions() throws {
        let config = PDFStylingConfig(
            defaultFont: "Arial, sans-serif",
            defaultFontSize: 12,
            monoFont: "Consolas, monospace",
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
        
        let docxConfig = config.toDocxConfig()
        
        // Test font size conversions (points → half-points)
        XCTAssertEqual(docxConfig.headings.h1.font.size, 36) // 18pt * 2
        XCTAssertEqual(docxConfig.headings.h2.font.size, 28) // 14pt * 2
        XCTAssertEqual(docxConfig.headings.h3.font.size, 24) // 12pt * 2
        XCTAssertEqual(docxConfig.codeBlocks.font.size, 22) // 11pt * 2
        
        // Test margin conversions (points → twips)
        XCTAssertEqual(docxConfig.pageMargins.top.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.bottom.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.left.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.right.twips, 800) // 40pt * 20
        
        // Test spacing conversions (points → twips)
        XCTAssertEqual(docxConfig.paragraphs.spacing.before, 200) // 10pt * 20
        XCTAssertEqual(docxConfig.paragraphs.spacing.after, 200) // 10pt * 20
        XCTAssertEqual(docxConfig.headings.h1.spacing.before, 280) // 14pt * 20
        XCTAssertEqual(docxConfig.headings.h1.spacing.after, 280) // 14pt * 20
        XCTAssertEqual(docxConfig.lists.indentation, 100) // 5pt * 20
        
        // Test line height conversion (multiplier → twips)
        XCTAssertEqual(docxConfig.lineSpacing.value, 360) // 1.5 * 240
        
        // Test color conversions (remove #)
        XCTAssertEqual(docxConfig.defaultFont.color, "333333")
        XCTAssertEqual(docxConfig.headings.h1.font.color, "000000")
        XCTAssertEqual(docxConfig.linkColor, "0066cc")
        XCTAssertEqual(docxConfig.codeBlocks.background, "f5f5f5")
    }
    
    func testFontStackExtraction() throws {
        let config = PDFStylingConfig(
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
        
        let docxConfig = config.toDocxConfig()
        
        // Test that primary fonts are extracted correctly
        XCTAssertEqual(docxConfig.defaultFont.name, "-apple-system")
        XCTAssertEqual(docxConfig.codeBlocks.font.name, "SF Mono")
    }
    
    func testPageSizeMapping() throws {
        // Test letter size mapping
        let letterConfig = PDFStylingConfig(
            defaultFont: "Arial",
            defaultFontSize: 12,
            monoFont: "Consolas",
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
        
        let letterDocxConfig = letterConfig.toDocxConfig()
        XCTAssertEqual(letterDocxConfig.pageSize.width.twips, 12240) // 612pt * 20
        XCTAssertEqual(letterDocxConfig.pageSize.height.twips, 15840) // 792pt * 20
        
        // Test A4 size mapping
        let a4Config = PDFStylingConfig(
            defaultFont: "Arial",
            defaultFontSize: 12,
            monoFont: "Consolas",
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
            pageWidth: 595.0,
            pageHeight: 842.0
        )
        
        let a4DocxConfig = a4Config.toDocxConfig()
        XCTAssertEqual(a4DocxConfig.pageSize.width.twips, 11900) // 595pt * 20
        XCTAssertEqual(a4DocxConfig.pageSize.height.twips, 16840) // 842pt * 20
    }
    
    func testColorHandling() throws {
        let config = PDFStylingConfig(
            defaultFont: "Arial",
            defaultFontSize: 12,
            monoFont: "Consolas",
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
            textColor: "333333", // Without #
            headingColor: "#000000", // With #
            linkColor: "0066cc", // Without #
            codeBackgroundColor: "#f5f5f5", // With #
            pageWidth: 612.0,
            pageHeight: 792.0
        )
        
        let docxConfig = config.toDocxConfig()
        
        // Test that colors are handled correctly regardless of # prefix
        XCTAssertEqual(docxConfig.defaultFont.color, "333333")
        XCTAssertEqual(docxConfig.headings.h1.font.color, "000000")
        XCTAssertEqual(docxConfig.linkColor, "0066cc")
        XCTAssertEqual(docxConfig.codeBlocks.background, "f5f5f5")
    }
    
    func testDocumentGeneration() throws {
        let config = PDFStylingConfig.coverLetterOptimized
        let converter = config.createDocxConverter()
        
        let markdown = """
        # Test Document
        
        This is a **bold** and *italic* test document with [links](https://example.com).
        
        ## Features
        
        - Bullet point 1
        - Bullet point 2
        
        ```swift
        let code = "This is a code block"
        print(code)
        ```
        
        > This is a blockquote with important information.
        """
        
        let docxData = try converter.convert(markdown: markdown)
        
        // Verify the document was generated successfully
        XCTAssertFalse(docxData.isEmpty)
        
        // Extract and verify the document contains our configuration
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("test_glue_docx.docx")
        try docxData.write(to: tempURL)
        let archive = try Archive(url: tempURL, accessMode: .read)
        
        // Check that document.xml exists
        XCTAssertNotNil(archive["word/document.xml"])
        
        // Check that styles.xml exists
        XCTAssertNotNil(archive["word/styles.xml"])
        
        // Check that settings.xml exists
        XCTAssertNotNil(archive["word/settings.xml"])
    }
    
    func testCSSGeneration() throws {
        let config = PDFStylingConfig.coverLetterOptimized
        let css = config.generateCSS()
        
        // Verify CSS contains expected elements
        XCTAssertTrue(css.contains("font-family"))
        XCTAssertTrue(css.contains("font-size"))
        XCTAssertTrue(css.contains("line-height"))
        XCTAssertTrue(css.contains("color"))
        XCTAssertTrue(css.contains("padding"))
        
        // Verify specific values are present
        XCTAssertTrue(css.contains("12pt"))
        XCTAssertTrue(css.contains("18pt"))
        XCTAssertTrue(css.contains("1.5"))
        XCTAssertTrue(css.contains("#333333"))
        XCTAssertTrue(css.contains("40.0pt") || css.contains("40pt")) // Handle both Double and Int formatting
    }
    
    func testConfigurationEquivalence() throws {
        // Test that the coverLetterOptimized config matches the manual conversion we did earlier
        let pdfConfig = PDFStylingConfig.coverLetterOptimized
        let docxConfig = pdfConfig.toDocxConfig()
        
        // Verify key properties match our expected conversions
        XCTAssertEqual(docxConfig.pageSize.width.twips, 12240) // 612pt * 20
        XCTAssertEqual(docxConfig.pageSize.height.twips, 15840) // 792pt * 20
        
        XCTAssertEqual(docxConfig.pageMargins.top.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.bottom.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.left.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.right.twips, 800) // 40pt * 20
        
        XCTAssertEqual(docxConfig.defaultFont.size.twips, 240) // 12pt * 20
        XCTAssertEqual(docxConfig.defaultFont.color, "333333")
        
        XCTAssertEqual(docxConfig.lineSpacing.type, LineSpacingType.multiple)
        XCTAssertEqual(docxConfig.lineSpacing.value, 360) // 1.5 * 240
        
        XCTAssertEqual(docxConfig.headings.h1.font.size, 36) // 18pt * 2
        XCTAssertEqual(docxConfig.headings.h2.font.size, 28) // 14pt * 2
        XCTAssertEqual(docxConfig.headings.h3.font.size, 24) // 12pt * 2
        
        XCTAssertEqual(docxConfig.paragraphs.spacing.before, 200) // 10pt * 20
        XCTAssertEqual(docxConfig.paragraphs.spacing.after, 200) // 10pt * 20
        
        XCTAssertEqual(docxConfig.codeBlocks.font.size, 22) // 11pt * 2
        XCTAssertEqual(docxConfig.codeBlocks.background, "f5f5f5")
        
        XCTAssertEqual(docxConfig.lists.indentation, 100) // 5pt * 20
        
        XCTAssertEqual(docxConfig.linkColor, "0066cc")
    }
    
    func testCustomPageSize() throws {
        let config = PDFStylingConfig(
            defaultFont: "Arial",
            defaultFontSize: 12,
            monoFont: "Consolas",
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
            pageWidth: 500.0, // Custom size
            pageHeight: 700.0 // Custom size
        )
        
        let docxConfig = config.toDocxConfig()
        
        // Test that custom page size is preserved
        XCTAssertEqual(docxConfig.pageSize.width.twips, 10000) // 500pt * 20
        XCTAssertEqual(docxConfig.pageSize.height.twips, 14000) // 700pt * 20
    }
    
    func testPerformance() throws {
        let config = PDFStylingConfig.coverLetterOptimized
        
        // Test conversion performance
        let startTime = CFAbsoluteTimeGetCurrent()
        
        for _ in 0..<1000 {
            _ = config.toDocxConfig()
        }
        
        let endTime = CFAbsoluteTimeGetCurrent()
        let duration = endTime - startTime
        
        // Should complete 1000 conversions in under 1 second
        XCTAssertLessThan(duration, 1.0, "Conversion should be fast")
    }
} 