//
//  PCKManager.swift
//  NativeBridge
//
//  Real SwiftGodotKit integration for PCK loading
//

// Enhanced PCK Detection with Comprehensive Debugging
// Add this to PCKManager.swift to debug the detection issue

import Foundation

class PCKManager: ObservableObject {
    @Published var detectedPath: String? = nil
    @Published var bundleInfo: String = ""
    @Published var searchResults: [String] = []
    
    init() {
        print("🔍 PCKManager: Initializing with enhanced detection...")
        detectPCKFiles()
        updateBundleInfo()
    }
    
    func detectPCKFiles() {
        print("🔍 PCK DETECTION: Starting Bundle Resource search...")
        searchResults.removeAll()
        
        // Method 1: Direct Bundle API search for game.pck
        if let gamePckPath = Bundle.main.path(forResource: "game", ofType: "pck") {
            print("✅ METHOD 1 SUCCESS: Found game.pck via Bundle.main.path")
            print("📍 Path: \(gamePckPath)")
            detectedPath = gamePckPath
            searchResults.append("✅ METHOD 1: Bundle.main.path found game.pck")
            validatePCKFile(at: gamePckPath)
            return
        } else {
            print("❌ METHOD 1: Bundle.main.path(forResource: 'game', ofType: 'pck') returned nil")
            searchResults.append("❌ METHOD 1: Bundle.main.path returned nil")
        }
        
        // Method 2: Search all PCK files in bundle
        let allPCKs = Bundle.main.paths(forResourcesOfType: "pck", inDirectory: nil)
        print("🔍 METHOD 2: Bundle.main.paths(forResourcesOfType: 'pck') found \(allPCKs.count) files:")
        for (index, pckPath) in allPCKs.enumerated() {
            print("  [\(index + 1)] \(pckPath)")
            searchResults.append("✅ METHOD 2: Found PCK #\(index + 1): \(pckPath)")
        }
        
        if let firstPCK = allPCKs.first {
            print("✅ METHOD 2 SUCCESS: Using first PCK file found")
            detectedPath = firstPCK
            validatePCKFile(at: firstPCK)
            return
        } else {
            searchResults.append("❌ METHOD 2: No PCK files found via Bundle.main.paths")
        }
        
        // Method 3: Check bundle contents manually
        print("🔍 METHOD 3: Manual bundle inspection...")
        let bundle = Bundle.main
        
        if let resourcePath = bundle.resourcePath {
            print("📁 Resource path: \(resourcePath)")
            searchResults.append("📁 Resource path: \(resourcePath)")
            
            do {
                let allResources = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                let pckFiles = allResources.filter { $0.hasSuffix(".pck") }
                
                print("📋 All resources in bundle: \(allResources.count) items")
                print("🎯 PCK files found: \(pckFiles)")
                searchResults.append("📋 Total resources: \(allResources.count), PCK files: \(pckFiles.count)")
                
                if let pckFile = pckFiles.first {
                    let fullPath = "\(resourcePath)/\(pckFile)"
                    print("✅ METHOD 3 SUCCESS: Found \(pckFile)")
                    print("📍 Full path: \(fullPath)")
                    detectedPath = fullPath
                    searchResults.append("✅ METHOD 3: Found \(pckFile)")
                    validatePCKFile(at: fullPath)
                    return
                } else {
                    searchResults.append("❌ METHOD 3: No .pck files in resource directory")
                }
            } catch {
                print("❌ METHOD 3 ERROR: \(error)")
                searchResults.append("❌ METHOD 3 ERROR: \(error.localizedDescription)")
            }
        }
        
        // Method 4: Check if it's in a subdirectory
        print("🔍 METHOD 4: Checking subdirectories...")
        let subdirs = ["GameContent", "PCK", "Pack", "Resources"]
        
        for subdir in subdirs {
            if let subdirPck = Bundle.main.path(forResource: "game", ofType: "pck", inDirectory: subdir) {
                print("✅ METHOD 4 SUCCESS: Found in \(subdir) subdirectory")
                print("📍 Path: \(subdirPck)")
                detectedPath = subdirPck
                searchResults.append("✅ METHOD 4: Found in \(subdir) subdirectory")
                validatePCKFile(at: subdirPck)
                return
            } else {
                print("❌ METHOD 4: Not found in \(subdir)")
                searchResults.append("❌ METHOD 4: Not found in \(subdir)")
            }
        }
        
        print("❌ ALL METHODS FAILED: No PCK file found")
        searchResults.append("❌ ALL METHODS FAILED: No PCK file detected")
        
        // Final debug: Show us what IS in the bundle
        debugBundleContents()
    }
    
    func validatePCKFile(at path: String) {
        print("🧪 Validating PCK file at: \(path)")
        
        let fileExists = FileManager.default.fileExists(atPath: path)
        print("  File exists: \(fileExists)")
        
        if fileExists {
            do {
                let attributes = try FileManager.default.attributesOfItem(atPath: path)
                let fileSize = attributes[.size] as? Int64 ?? 0
                let sizeInMB = Double(fileSize) / (1024 * 1024)
                print("  File size: \(String(format: "%.2f", sizeInMB)) MB")
                
                // Basic file validation - check if it starts with expected PCK header
                let fileData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let headerBytes = fileData.prefix(4)
                let headerString = String(data: headerBytes, encoding: .utf8) ?? "Unknown"
                print("  Header bytes: \(headerBytes.map { String(format: "%02X", $0) }.joined(separator: " "))")
                print("  Header string: \(headerString)")
                
                searchResults.append("✅ PCK Validation: \(String(format: "%.2f", sizeInMB)) MB, Header: \(headerString)")
                
            } catch {
                print("  ❌ Error validating file: \(error)")
                searchResults.append("❌ PCK Validation Error: \(error.localizedDescription)")
            }
        } else {
            searchResults.append("❌ PCK file does not exist at detected path")
        }
    }
    
    func debugBundleContents() {
        print("🔍 FINAL DEBUG: Complete bundle contents analysis...")
        
        let bundle = Bundle.main
        print("📦 Bundle path: \(bundle.bundlePath)")
        print("📦 Bundle identifier: \(bundle.bundleIdentifier ?? "Unknown")")
        
        if let resourcePath = bundle.resourcePath {
            print("📁 Resource path: \(resourcePath)")
            
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                print("📋 Bundle resource contents (\(contents.count) items):")
                
                for item in contents.sorted() {
                    let itemPath = "\(resourcePath)/\(item)"
                    var isDirectory: ObjCBool = false
                    FileManager.default.fileExists(atPath: itemPath, isDirectory: &isDirectory)
                    
                    let type = isDirectory.boolValue ? "📁" : "📄"
                    let fileExtension = (item as NSString).pathExtension
                    let highlight = fileExtension == "pck" ? " ⭐ PCK FILE!" : ""
                    
                    print("  \(type) \(item)\(highlight)")
                    searchResults.append("\(type) \(item)\(highlight)")
                }
            } catch {
                print("❌ Error reading bundle contents: \(error)")
                searchResults.append("❌ Bundle contents error: \(error.localizedDescription)")
            }
        }
    }
    
    func updateBundleInfo() {
        let bundle = Bundle.main
        bundleInfo = """
        Bundle: \(bundle.bundleIdentifier ?? "Unknown")
        Path: \(bundle.bundlePath)
        Resource Path: \(bundle.resourcePath ?? "None")
        PCK Detected: \(detectedPath != nil ? "✅" : "❌")
        """
    }
    
    // Force re-detection method for UI
    func forceRedetection() {
        print("🔄 PCKManager: Force re-detection requested...")
        detectedPath = nil
        searchResults.removeAll()
        detectPCKFiles()
        updateBundleInfo()
    }
    
    // Get human-readable status for UI
    var detectionStatus: String {
        if let path = detectedPath {
            let fileName = (path as NSString).lastPathComponent
            return "✅ Found: \(fileName)"
        } else {
            return "❌ No PCK Found"
        }
    }
    
    // Get detailed search results for UI
    var searchSummary: String {
        if searchResults.isEmpty {
            return "No search performed yet"
        }
        
        let successCount = searchResults.filter { $0.contains("✅") }.count
        let failureCount = searchResults.filter { $0.contains("❌") }.count
        
        return "Search completed: \(successCount) successes, \(failureCount) failures"
    }
}
