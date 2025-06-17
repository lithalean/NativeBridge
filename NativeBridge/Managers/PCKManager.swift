//
//  PCKManager.swift
//  NativeBridge
//
//  Created by Tyler Allen on 6/13/25.
//

//
//  PCKManager.swift
//  DarwinHost
//
//  Created by Tyler Allen on 6/11/25.
//

import Foundation

@MainActor
class PCKManager: ObservableObject {
    @Published var status: PCKStatus = .loading
    @Published var errorMessage: String = ""
    @Published var detectedPath: String = ""
    @Published var debugInfo: [String] = []
    
    enum PCKStatus {
        case loading
        case found
        case notFound
        case error
    }
    
    // Configuration
    private let possibleFolders = ["GameContent", "PCK", "Pack", "GameData"]
    private let pckFileName = "game.pck"
    
    // MARK: - Public Methods
    
    func checkForPCK() {
        status = .loading
        errorMessage = ""
        detectedPath = ""
        debugInfo = []
        
        Task {
            do {
                let result = try findPCKFile()
                updateStatus(result)
            } catch {
                handleError(error)
            }
        }
    }
    
    func debugBundleContents() {
        Task {
            let info = getBundleDebugInfo()
            debugInfo = info
        }
    }
    
    // MARK: - Private Methods
    
    private func findPCKFile() throws -> PCKResult {
        guard let bundlePath = Bundle.main.resourcePath else {
            throw PCKError.bundleNotFound
        }
        
        let fileManager = FileManager.default
        
        // Try to find existing folder with PCK file
        for folder in possibleFolders {
            let folderPath = "\(bundlePath)/\(folder)"
            let pckPath = "\(folderPath)/\(pckFileName)"
            
            if fileManager.fileExists(atPath: folderPath) {
                if fileManager.fileExists(atPath: pckPath) {
                    return PCKResult(found: true, path: pckPath, folder: folder)
                } else {
                    return PCKResult(found: false, path: pckPath, folder: folder,
                                   error: "Folder '\(folder)' exists but '\(pckFileName)' not found")
                }
            }
        }
        
        // No folders found - return default path
        let defaultPath = "\(bundlePath)/\(possibleFolders[0])/\(pckFileName)"
        return PCKResult(found: false, path: defaultPath, folder: nil,
                        error: "No game content folders found. Expected: \(possibleFolders.joined(separator: ", "))")
    }
    
    private func updateStatus(_ result: PCKResult) {
        detectedPath = result.path
        
        if result.found {
            status = .found
        } else {
            status = .notFound
            if let error = result.error {
                errorMessage = error
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let pckError = error as? PCKError {
            errorMessage = pckError.localizedDescription
        } else {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        status = .error
    }
    
    private func getBundleDebugInfo() -> [String] {
        guard let bundlePath = Bundle.main.resourcePath else {
            return ["❌ Cannot access bundle path"]
        }
        
        var info: [String] = []
        let fileManager = FileManager.default
        
        info.append("📦 Bundle: \(bundlePath)")
        
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: bundlePath)
            info.append("📁 Root contents: \(contents.count) items")
            
            // Check each possible folder
            for folder in possibleFolders {
                let folderPath = "\(bundlePath)/\(folder)"
                if fileManager.fileExists(atPath: folderPath) {
                    do {
                        let folderContents = try fileManager.contentsOfDirectory(atPath: folderPath)
                        info.append("✅ \(folder)/: \(folderContents)")
                        
                        // Check for PCK file specifically
                        let pckPath = "\(folderPath)/\(pckFileName)"
                        if fileManager.fileExists(atPath: pckPath) {
                            let attributes = try fileManager.attributesOfItem(atPath: pckPath)
                            let size = attributes[.size] as? Int64 ?? 0
                            info.append("   🎮 \(pckFileName): \(formatFileSize(size))")
                        }
                    } catch {
                        info.append("❌ \(folder)/: Error reading contents")
                    }
                } else {
                    info.append("❌ \(folder)/: Not found")
                }
            }
        } catch {
            info.append("❌ Error reading bundle contents: \(error)")
        }
        
        return info
    }
    
    private func formatFileSize(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
}

// MARK: - Supporting Types

struct PCKResult {
    let found: Bool
    let path: String
    let folder: String?
    let error: String?
    
    init(found: Bool, path: String, folder: String?, error: String? = nil) {
        self.found = found
        self.path = path
        self.folder = folder
        self.error = error
    }
}

enum PCKError: LocalizedError {
    case bundleNotFound
    case fileNotFound(String)
    case invalidPath(String)
    
    var errorDescription: String? {
        switch self {
        case .bundleNotFound:
            return "Could not access app bundle"
        case .fileNotFound(let path):
            return "PCK file not found at: \(path)"
        case .invalidPath(let path):
            return "Invalid path: \(path)"
        }
    }
}
