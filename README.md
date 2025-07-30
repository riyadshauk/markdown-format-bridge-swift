# Markdown Format Bridge

A bridge library that provides seamless conversion between PDF styling configuration and DOCX styling configuration, allowing users to use the same configuration for both PDF and DOCX generation.

## Overview

The `MarkdownFormatBridge` library provides a `PDFStylingConfig` struct that matches the PDF configuration format used in other projects, along with conversion methods to transform it into DOCX configuration. This enables:

- **Shared configurations** between PDF and DOCX generation
- **Automatic unit conversions** between different measurement systems
- **Font stack handling** for cross-platform compatibility
- **Predefined configurations** for common use cases

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/riyadshauk/markdown-format-bridge.git", from: "1.0.0")
]
```

Or add it to your Xcode project:
1. File → Add Package Dependencies
2. Enter the repository URL
3. Select the version you want to use

## Usage

### Basic Usage

```swift
import MarkdownFormatBridge

// Use a predefined configuration
let config = PDFStylingConfig.coverLetterOptimized

// Convert to DOCX and create converter
let converter = config.createDocxConverter()

// Convert markdown to DOCX
let docxData = try converter.convert(markdown: markdown)
```

### Custom Configuration

```swift
// Create custom configuration
let customConfig = PDFStylingConfig(
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

// Convert and use
let converter = customConfig.createDocxConverter()
let docxData = try converter.convert(markdown: markdown)
```

## Predefined Configurations

The library includes several predefined configurations optimized for different use cases:

### `PDFStylingConfig.default`
Standard configuration with balanced readability and space usage.

### `PDFStylingConfig.compact`
Optimized for dense content with smaller fonts and tighter spacing.

### `PDFStylingConfig.largePrint`
Large fonts and generous spacing for accessibility.

### `PDFStylingConfig.resumeOptimized`
Professional, compact styling ideal for resumes.

### `PDFStylingConfig.coverLetterOptimized`
Formal, readable styling perfect for cover letters.

## Unit Conversions and Assumptions

The bridge library handles all unit conversions automatically. Here are the key assumptions and conversions:

### Font Sizes
- **PDF**: Points (pt)
- **DOCX**: Half-points (1/2 pt)
- **Conversion**: `PDF points × 2 = DOCX half-points`

```swift
// PDF: 12pt → DOCX: 24 half-points
// PDF: 18pt → DOCX: 36 half-points
```

### Margins and Spacing
- **PDF**: Points (pt)
- **DOCX**: Twips (1/20th of a point)
- **Conversion**: `PDF points × 20 = DOCX twips`

```swift
// PDF: 40pt margin → DOCX: 800 twips
// PDF: 10pt spacing → DOCX: 200 twips
```

### Line Height
- **PDF**: Multiplier (e.g., 1.5 = 150% line height)
- **DOCX**: Twips
- **Conversion**: `PDF multiplier × 240 = DOCX twips` (based on 12pt font)

```swift
// PDF: 1.5 line height → DOCX: 360 twips
// PDF: 1.2 line height → DOCX: 288 twips
```

### Colors
- **PDF**: Hex with or without # prefix
- **DOCX**: Hex without # prefix
- **Conversion**: Automatic # removal

```swift
// PDF: "#333333" → DOCX: "333333"
// PDF: "0066cc" → DOCX: "0066cc"
```

### Page Sizes
- **PDF**: Custom dimensions in points
- **DOCX**: Predefined page sizes or custom dimensions
- **Conversion**: Automatic mapping to standard sizes

```swift
// PDF: 612×792 points → DOCX: .letter
// PDF: 595×842 points → DOCX: .a4
// PDF: Custom dimensions → DOCX: Custom PageSize
```

## Font Handling

### Font Stack Extraction
The library extracts the primary font from CSS-style font stacks:

```swift
// Input: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif"
// Output: "-apple-system"

// Input: "'SF Mono', Monaco, 'Cascadia Code', monospace"
// Output: "SF Mono"
```

### Font Mapping
Common system fonts are mapped to DOCX equivalents:

| PDF Font | DOCX Font | Notes |
|----------|-----------|-------|
| `-apple-system` | `Calibri` | System font fallback |
| `SF Mono` | `Consolas` | Monospace equivalent |
| `Times New Roman` | `Times New Roman` | Direct mapping |
| `Arial` | `Arial` | Direct mapping |

## Page Size Mapping

The library automatically maps common page dimensions to predefined DOCX page sizes:

| Dimensions (points) | DOCX Page Size | Description |
|---------------------|----------------|-------------|
| 612×792 | `.letter` | US Letter (8.5"×11") |
| 612×1008 | `.legal` | US Legal (8.5"×14") |
| 595×842 | `.a4` | A4 (210×297mm) |
| 842×1191 | `.a3` | A3 (297×420mm) |
| 420×595 | `.a5` | A5 (148×210mm) |
| 522×756 | `.executive` | Executive (7.25"×10.5") |
| 792×1224 | `.tabloid` | Tabloid (11"×17") |

Custom dimensions create a custom `PageSize` with the exact dimensions.

## Advanced Usage

### Manual Conversion

```swift
let pdfConfig = PDFStylingConfig.coverLetterOptimized

// Convert to DOCX config
let docxConfig = pdfConfig.toDocxConfig()

// Use the DOCX config directly
let converter = MarkdownToDocxConverter(userFriendlyConfig: docxConfig)
```

### CSS Generation

The library can also generate CSS for PDF generation:

```swift
let config = PDFStylingConfig.default
let css = config.generateCSS()
// Use CSS with your PDF generation system
```

### Configuration Comparison

```swift
// Compare different configurations
let configs = [
    PDFStylingConfig.default,
    PDFStylingConfig.compact,
    PDFStylingConfig.largePrint
]

for config in configs {
    let converter = config.createDocxConverter()
    let docxData = try converter.convert(markdown: markdown)
    // Process each configuration...
}
```

## Error Handling

The conversion process is designed to be robust and handle edge cases:

- **Invalid font stacks**: Falls back to "Calibri"
- **Invalid colors**: Preserves as-is (DOCX will handle invalid colors)
- **Custom page sizes**: Creates custom PageSize with exact dimensions
- **Missing values**: Uses sensible defaults

## Performance Considerations

- **Conversion is fast**: Simple mathematical operations
- **No network calls**: All conversions are local
- **Memory efficient**: Minimal object creation
- **Caching friendly**: Convert once, reuse many times

## Migration from Existing Code

If you have existing PDF configuration code, migration is straightforward:

```swift
// Old PDF-only code
struct MyPDFConfig {
    var fontSize: Int = 12
    var margin: Double = 40.0
    // ... other properties
}

// New shared code
let config = PDFStylingConfig(
    defaultFontSize: 12,
    topMargin: 40.0,
    // ... other properties
)

// Use for both PDF and DOCX
let pdfCSS = config.generateCSS()        // For PDF
let docxConverter = config.createDocxConverter()  // For DOCX
```

## Best Practices

1. **Use predefined configurations** when possible for consistency
2. **Test both PDF and DOCX output** with the same configuration
3. **Document custom configurations** for team sharing
4. **Consider accessibility** when choosing font sizes and spacing
5. **Validate color choices** for contrast and readability

## Troubleshooting

### Common Issues

**Font not appearing correctly in DOCX:**
- Check that the primary font is available on the target system
- Consider using system font stacks for better compatibility

**Spacing looks different between PDF and DOCX:**
- This is expected due to different rendering engines
- Fine-tune spacing values for each format if needed

**Page size not matching:**
- Verify that page dimensions match standard sizes exactly
- Use custom PageSize for non-standard dimensions

### Debugging

```swift
let config = PDFStylingConfig.coverLetterOptimized
let docxConfig = config.toDocxConfig()

// Inspect the converted configuration
print("Page size: \(docxConfig.pageSize)")
print("Font: \(docxConfig.defaultFont.name)")
print("Margins: \(docxConfig.pageMargins)")
```

## API Reference

### PDFStylingConfig

The main configuration struct with the following properties:

- **Font settings**: `defaultFont`, `defaultFontSize`, `monoFont`, `monoFontSize`
- **Heading sizes**: `h1FontSize`, `h2FontSize`, `h3FontSize`
- **Spacing**: `lineHeight`, `paragraphSpacing`, `headingSpacing`, `listItemSpacing`
- **Margins**: `topMargin`, `bottomMargin`, `leftMargin`, `rightMargin`
- **Colors**: `textColor`, `headingColor`, `linkColor`, `codeBackgroundColor`
- **Page settings**: `pageWidth`, `pageHeight`

### Methods

- `toDocxConfig() -> UserFriendlyDocxStylingConfig`: Convert to DOCX configuration
- `createDocxConverter() -> MarkdownToDocxConverter`: Create DOCX converter
- `generateCSS() -> String`: Generate CSS for PDF generation
- `pageSize -> CGSize`: Get page size as CGSize

### Predefined Configurations

- `PDFStylingConfig.default`
- `PDFStylingConfig.compact`
- `PDFStylingConfig.largePrint`
- `PDFStylingConfig.resumeOptimized`
- `PDFStylingConfig.coverLetterOptimized`

## Dependencies

- [markdown-docx-swift](https://github.com/riyadshauk/markdown-docx-swift) - Core DOCX generation functionality

## Requirements

- iOS 15.0+ / macOS 12.0+ / tvOS 15.0+ / watchOS 8.0+
- Swift 5.9+

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 