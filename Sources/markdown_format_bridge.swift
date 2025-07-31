//
//  markdown_format_bridge.swift
//  MarkdownFormatBridge
//
//  A bridge library that provides seamless conversion between PDF styling configuration
//  and DOCX styling configuration, allowing users to use the same configuration
//  for both PDF and DOCX generation.
//
//  Created by Riyad Shauk on 7/30/25.
//

import Foundation
import MarkdownToDocx

// Re-export the main types for easy access
@_exported import struct MarkdownToDocx.UserFriendlyDocxStylingConfig
@_exported import class MarkdownToDocx.MarkdownToDocxConverter

// The main PDFStylingConfig and conversion logic is in PDFToDocxConfig.swift
