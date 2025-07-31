import XCTest
import MarkdownFormatBridge
import ZIPFoundation

final class SpacingTests: XCTestCase {
    
    func testLineSpacingAndParagraphSpacing() throws {
        // Test markdown with multiple paragraphs to verify spacing
        let testMarkdown = """
        # Test Document

        This is the first paragraph. It should have proper line spacing (1.5x) and paragraph spacing.

        This is the second paragraph. There should be spacing between this paragraph and the previous one.

        This is the third paragraph. The spacing should be consistent throughout the document.

        ## Subheading

        This paragraph comes after a heading. It should have proper spacing from the heading.

        This is another paragraph to test spacing consistency.

        - List item 1
        - List item 2
        - List item 3

        This paragraph comes after a list and should have proper spacing.

        **Bold text** and *italic text* should maintain proper line spacing.

        This is the final paragraph to test end-of-document spacing.
        """

        // Use the cover letter optimized configuration
        let config = PDFStylingConfig.coverLetterOptimized
        let converter = config.createDocxConverter()

        let docxData = try converter.convert(markdown: testMarkdown)
        
        // Verify the document was generated
        XCTAssertGreaterThan(docxData.count, 0, "Document should be generated with content")
        
        // Extract and examine the styles.xml to verify spacing is applied
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("spacing_test.docx")
        try docxData.write(to: tempURL)
        
        let archive = try Archive(url: tempURL, accessMode: .read)
        
        // Find and extract styles.xml
        guard let stylesEntry = archive.first(where: { $0.path.hasSuffix("styles.xml") }) else {
            XCTFail("Could not find styles.xml in DOCX archive")
            return
        }
        
        let stylesTempURL = FileManager.default.temporaryDirectory.appendingPathComponent("styles.xml")
        try archive.extract(stylesEntry, to: stylesTempURL)
        let stylesContent = try String(contentsOf: stylesTempURL, encoding: .utf8)
        
        // Verify line spacing is applied to Normal style
        
        // Verify line spacing is applied to Normal style
        XCTAssertTrue(stylesContent.contains("<w:spacing w:line=\"360\" w:lineRule=\"auto\"/>"), 
                     "Normal style should have 1.5 line spacing (360 twips)")
        
        // Verify paragraph spacing is applied to Normal style
        XCTAssertTrue(stylesContent.contains("<w:spacing w:before=\"200\" w:after=\"200\"/>"), 
                     "Normal style should have paragraph spacing (200 twips = 10pt)")
        
        // Verify heading spacing is applied
        XCTAssertTrue(stylesContent.contains("<w:spacing w:before=\"280\" w:after=\"280\"/>"), 
                     "Headings should have spacing (280 twips = 14pt)")
        
        // Extract and examine document.xml to verify page margins
        guard let documentEntry = archive.first(where: { $0.path.hasSuffix("document.xml") }) else {
            XCTFail("Could not find document.xml in DOCX archive")
            return
        }
        
        let documentTempURL = FileManager.default.temporaryDirectory.appendingPathComponent("document.xml")
        try archive.extract(documentEntry, to: documentTempURL)
        let documentContent = try String(contentsOf: documentTempURL, encoding: .utf8)
        
        // Verify page margins are applied
        
        // Verify page margins are applied
        XCTAssertTrue(documentContent.contains("<w:pgMar w:top=\"800\" w:right=\"800\" w:bottom=\"800\" w:left=\"800\""), 
                     "Page margins should be set to 800 twips (40pt)")
        
        // Verify page size is applied
        XCTAssertTrue(documentContent.contains("<w:pgSz w:w=\"12240\" w:h=\"15840\""), 
                     "Page size should be set to Letter size in twips")
        
        // Clean up
        try? FileManager.default.removeItem(at: tempURL)
        try? FileManager.default.removeItem(at: stylesTempURL)
        try? FileManager.default.removeItem(at: documentTempURL)
    }
    
    func testSpacingConfigurationValues() throws {
        let config = PDFStylingConfig.coverLetterOptimized
        let docxConfig = config.toDocxConfig()
        
        // Test line spacing conversion
        XCTAssertEqual(docxConfig.lineSpacing.type, .multiple)
        XCTAssertEqual(docxConfig.lineSpacing.value, 360) // 1.5 * 240
        
        // Test paragraph spacing conversion
        XCTAssertEqual(docxConfig.paragraphs.spacing.before, 200) // 10pt * 20
        XCTAssertEqual(docxConfig.paragraphs.spacing.after, 200) // 10pt * 20
        
        // Test heading spacing conversion
        XCTAssertEqual(docxConfig.headings.h1.spacing.before, 280) // 14pt * 20
        XCTAssertEqual(docxConfig.headings.h1.spacing.after, 280) // 14pt * 20
        
        // Test page margins conversion
        XCTAssertEqual(docxConfig.pageMargins.top.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.bottom.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.left.twips, 800) // 40pt * 20
        XCTAssertEqual(docxConfig.pageMargins.right.twips, 800) // 40pt * 20
    }
    
    func testDoubleNewlinesPreserved() throws {
        // Test that double newlines in markdown create proper paragraph spacing
        let testMarkdown = """
        First paragraph.

        Second paragraph with double newline before it.

        Third paragraph with double newline before it.
        """
        
        let config = PDFStylingConfig.coverLetterOptimized
        let converter = config.createDocxConverter()
        
        let docxData = try converter.convert(markdown: testMarkdown)
        
        // Extract document.xml to verify paragraph structure
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("double_newlines_test.docx")
        try docxData.write(to: tempURL)
        
        let archive = try Archive(url: tempURL, accessMode: .read)
        guard let documentEntry = archive.first(where: { $0.path.hasSuffix("document.xml") }) else {
            XCTFail("Could not find document.xml in DOCX archive")
            return
        }
        
        let documentTempURL = FileManager.default.temporaryDirectory.appendingPathComponent("document.xml")
        try archive.extract(documentEntry, to: documentTempURL)
        let documentContent = try String(contentsOf: documentTempURL, encoding: .utf8)
        
        // Count paragraph elements to verify structure
        let paragraphCount = documentContent.components(separatedBy: "<w:p>").count - 1
        XCTAssertEqual(paragraphCount, 3, "Should have 3 paragraphs from the markdown")
        
        // Clean up
        try? FileManager.default.removeItem(at: tempURL)
        try? FileManager.default.removeItem(at: documentTempURL)
    }
} 