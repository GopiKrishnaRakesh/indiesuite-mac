import XCTest
#if canImport(Pathway)
@testable import Pathway
#endif

final class PathwayTests: XCTestCase {
    var tempDir: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tempDir = FileManager.default.temporaryDirectory.appendingPathComponent("PathwayTests-\(UUID().uuidString)").resolvingSymlinksInPath()
        try FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)
    }

    override func tearDownWithError() throws {
        if let dir = tempDir, FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.removeItem(at: dir)
        }
        try super.tearDownWithError()
    }

    // MARK: - FileOps Tests
    func testUniqueURLCopyNaming() {
        let file = tempDir.appendingPathComponent("document.txt")
        FileManager.default.createFile(atPath: file.path, contents: Data("test".utf8))

        let copy1 = FileOps.uniqueURL(named: "document.txt", in: tempDir, copy: true)
        XCTAssertEqual(copy1.lastPathComponent, "document - Copy.txt")

        FileManager.default.createFile(atPath: copy1.path, contents: Data("test".utf8))
        let copy2 = FileOps.uniqueURL(named: "document.txt", in: tempDir, copy: true)
        XCTAssertEqual(copy2.lastPathComponent, "document - Copy (2).txt")
    }

    func testUniqueURLMoveNaming() {
        let file = tempDir.appendingPathComponent("photo.jpg")
        FileManager.default.createFile(atPath: file.path, contents: Data("photo".utf8))

        let move1 = FileOps.uniqueURL(named: "photo.jpg", in: tempDir, copy: false)
        XCTAssertEqual(move1.lastPathComponent, "photo (2).jpg")
    }

    func testIsInsidePathBoundaries() {
        let parent = URL(fileURLWithPath: "/Users/test/folder")
        let child = URL(fileURLWithPath: "/Users/test/folder/child.txt")
        let sibling = URL(fileURLWithPath: "/Users/test/folder_other/file.txt")

        XCTAssertTrue(FileOps.isInside(child, of: parent))
        XCTAssertTrue(FileOps.isInside(parent, of: parent))
        XCTAssertFalse(FileOps.isInside(sibling, of: parent))
    }

    func testCopyAndMoveOperations() throws {
        let src = tempDir.appendingPathComponent("source.txt")
        try "sample data".write(to: src, atomically: true, encoding: .utf8)

        let subDir = tempDir.appendingPathComponent("subfolder")
        try FileManager.default.createDirectory(at: subDir, withIntermediateDirectories: true)

        // Copy
        let copyResult = FileOps.copy([src], to: subDir)
        XCTAssertTrue(copyResult.errors.isEmpty)
        XCTAssertEqual(copyResult.pairs.count, 1)
        XCTAssertTrue(FileManager.default.fileExists(atPath: subDir.appendingPathComponent("source.txt").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: src.path))

        // Move
        let destDir = tempDir.appendingPathComponent("dest")
        try FileManager.default.createDirectory(at: destDir, withIntermediateDirectories: true)
        let moveResult = FileOps.move([src], to: destDir)
        XCTAssertTrue(moveResult.errors.isEmpty)
        XCTAssertEqual(moveResult.pairs.count, 1)
        XCTAssertFalse(FileManager.default.fileExists(atPath: src.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: destDir.appendingPathComponent("source.txt").path))
    }

    // MARK: - macOS Finder Features Tests
    func testMacTagColors() {
        XCTAssertEqual(MacTag.red.rawValue, "Red")
        XCTAssertEqual(MacTag.allCases.count, 7)
    }

    @MainActor
    func testFinderTagsOperations() throws {
        let file = tempDir.appendingPathComponent("tagged_doc.txt")
        try "tagged content".write(to: file, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)

        // Toggle "Red" tag
        model.toggleTag("Red", for: [file])
        let tagsAfterRed = (try? file.resourceValues(forKeys: [.tagNamesKey]))?.tagNames ?? []
        XCTAssertTrue(tagsAfterRed.contains("Red"))

        // Toggle "Blue" tag
        model.toggleTag("Blue", for: [file])
        let tagsAfterBoth = (try? file.resourceValues(forKeys: [.tagNamesKey]))?.tagNames ?? []
        XCTAssertTrue(tagsAfterBoth.contains("Red"))
        XCTAssertTrue(tagsAfterBoth.contains("Blue"))

        // Untoggle "Red" tag
        model.toggleTag("Red", for: [file])
        let tagsAfterUntoggle = (try? file.resourceValues(forKeys: [.tagNamesKey]))?.tagNames ?? []
        XCTAssertFalse(tagsAfterUntoggle.contains("Red"))
        XCTAssertTrue(tagsAfterUntoggle.contains("Blue"))

        // Clear tags
        model.clearTags(for: [file])
        let tagsAfterClear = (try? file.resourceValues(forKeys: [.tagNamesKey]))?.tagNames ?? []
        XCTAssertTrue(tagsAfterClear.isEmpty)
    }

    @MainActor
    func testMakeAliasOperation() throws {
        let original = tempDir.appendingPathComponent("original.txt")
        try "alias target".write(to: original, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        model.makeAlias([original])

        let expectedAlias = tempDir.appendingPathComponent("original alias.txt")
        XCTAssertTrue(FileManager.default.fileExists(atPath: expectedAlias.path))

        let destination = try FileManager.default.destinationOfSymbolicLink(atPath: expectedAlias.path)
        XCTAssertEqual(destination, original.path)
    }

    @MainActor
    func testViewModesIncludingColumns() {
        let modes = ViewMode.allCases
        XCTAssertTrue(modes.contains(.details))
        XCTAssertTrue(modes.contains(.icons))
        XCTAssertTrue(modes.contains(.tiles))
        XCTAssertTrue(modes.contains(.columns))
    }

    @MainActor
    func testPermissionManagerInitialization() {
        let manager = PermissionManager.shared
        manager.checkPermissions()
        // Must not crash and should report boolean states
        _ = manager.hasFullDiskAccess
        _ = manager.hasDesktopAccess
        _ = manager.hasDocumentsAccess
        _ = manager.hasDownloadsAccess
    }

    @MainActor
    func testOnboardingState() {
        let model = FileBrowserModel(start: tempDir)
        // Verify showOnboarding and showFeatureStore are toggleable
        model.showOnboarding = true
        XCTAssertTrue(model.showOnboarding)
        model.showFeatureStore = true
        XCTAssertTrue(model.showFeatureStore)
    }

    // MARK: - Multi-Selection & Marquee Tests
    @MainActor
    func testMultiSelectionOperations() async throws {
        let f1 = tempDir.appendingPathComponent("file1.txt")
        let f2 = tempDir.appendingPathComponent("file2.txt")
        let f3 = tempDir.appendingPathComponent("file3.txt")
        try "1".write(to: f1, atomically: true, encoding: .utf8)
        try "2".write(to: f2, atomically: true, encoding: .utf8)
        try "3".write(to: f3, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        guard let item1 = model.displayItems.first(where: { $0.url.lastPathComponent == "file1.txt" }),
              let item2 = model.displayItems.first(where: { $0.url.lastPathComponent == "file2.txt" }),
              let item3 = model.displayItems.first(where: { $0.url.lastPathComponent == "file3.txt" }) else {
            XCTFail("Items not loaded")
            return
        }

        // Select first
        model.clickSelect(item1, modifiers: [])
        XCTAssertEqual(model.selection, [item1.id])

        // Extend select second with Command
        model.clickSelect(item2, modifiers: [.command])
        XCTAssertEqual(model.selection, [item1.id, item2.id])

        // Invert selection
        model.invertSelection()
        XCTAssertEqual(model.selection, [item3.id])

        // Select none
        model.selectNone()
        XCTAssertTrue(model.selection.isEmpty)

        // Select all
        model.selectAll()
        XCTAssertEqual(model.selection.count, 3)
    }

    func testMarqueeBoxIntersectionCalculation() {
        let dragStart = CGPoint(x: 20, y: 20)
        let dragCurrent = CGPoint(x: 150, y: 120)
        let minX = min(dragStart.x, dragCurrent.x)
        let minY = min(dragStart.y, dragCurrent.y)
        let width = max(abs(dragCurrent.x - dragStart.x), 1)
        let height = max(abs(dragCurrent.y - dragStart.y), 1)
        let marqueeRect = CGRect(x: minX, y: minY, width: width, height: height)

        let cell1 = CGRect(x: 30, y: 30, width: 80, height: 60)
        let cell2 = CGRect(x: 100, y: 80, width: 80, height: 60)
        let cell3Out = CGRect(x: 300, y: 300, width: 80, height: 60)

        XCTAssertTrue(marqueeRect.intersects(cell1))
        XCTAssertTrue(marqueeRect.intersects(cell2))
        XCTAssertFalse(marqueeRect.intersects(cell3Out))
    }

    @MainActor
    func testMarqueeMultiSelectionAndModifiers() async throws {
        let f1 = tempDir.appendingPathComponent("file1.png")
        let f2 = tempDir.appendingPathComponent("file2.jpg")
        let f3 = tempDir.appendingPathComponent("file3.pdf")
        let f4 = tempDir.appendingPathComponent("file4.txt")
        try "1".write(to: f1, atomically: true, encoding: .utf8)
        try "2".write(to: f2, atomically: true, encoding: .utf8)
        try "3".write(to: f3, atomically: true, encoding: .utf8)
        try "4".write(to: f4, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        XCTAssertEqual(model.displayItems.count, 4)

        // Populate item frames (as reported by views)
        let frame1 = CGRect(x: 10, y: 10, width: 80, height: 80)
        let frame2 = CGRect(x: 100, y: 10, width: 80, height: 80)
        let frame3 = CGRect(x: 10, y: 100, width: 80, height: 80)
        let frame4 = CGRect(x: 100, y: 100, width: 80, height: 80)

        model.itemFrames[f1] = frame1
        model.itemFrames[f2] = frame2
        model.itemFrames[f3] = frame3
        model.itemFrames[f4] = frame4

        // Simulate marquee dragging across items 1 & 2
        let dragMarquee1 = CGRect(x: 5, y: 5, width: 180, height: 90)
        model.dragMarqueeRect = dragMarquee1

        let hits1 = model.itemFrames.filter { _, frame in dragMarquee1.intersects(frame) }.map(\.key)
        model.selection = Set(hits1)

        XCTAssertEqual(model.selection.count, 2)
        XCTAssertTrue(model.selection.contains(f1))
        XCTAssertTrue(model.selection.contains(f2))
        XCTAssertFalse(model.selection.contains(f3))
        XCTAssertFalse(model.selection.contains(f4))

        // Simulate Command-drag to union items 3
        let dragMarquee2 = CGRect(x: 5, y: 95, width: 90, height: 90)
        let hits2 = model.itemFrames.filter { _, frame in dragMarquee2.intersects(frame) }.map(\.key)
        model.selection = model.selection.union(hits2)

        XCTAssertEqual(model.selection.count, 3)
        XCTAssertTrue(model.selection.contains(f1))
        XCTAssertTrue(model.selection.contains(f2))
        XCTAssertTrue(model.selection.contains(f3))
        XCTAssertFalse(model.selection.contains(f4))

        // Complete drag
        model.dragMarqueeRect = nil
        XCTAssertNil(model.dragMarqueeRect)
        XCTAssertEqual(model.selection.count, 3) // Selection persists after drag ends
    }

    @MainActor
    func testNewFolderWithSelection() async throws {
        let f1 = tempDir.appendingPathComponent("docA.txt")
        let f2 = tempDir.appendingPathComponent("docB.txt")
        let f3 = tempDir.appendingPathComponent("keepOutside.txt")
        try "A".write(to: f1, atomically: true, encoding: .utf8)
        try "B".write(to: f2, atomically: true, encoding: .utf8)
        try "Outside".write(to: f3, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        guard let itemA = model.displayItems.first(where: { $0.url.lastPathComponent == "docA.txt" }),
              let itemB = model.displayItems.first(where: { $0.url.lastPathComponent == "docB.txt" }) else {
            XCTFail("Items not loaded")
            return
        }
        model.selection = [itemA.id, itemB.id]

        model.newFolderWithSelection()

        // Wait briefly for asynchronous file moving task to finish
        try await Task.sleep(nanoseconds: 300_000_000)

        // Verify folder was created
        let newFolder = tempDir.appendingPathComponent("New Folder with Items")
        XCTAssertTrue(FileManager.default.fileExists(atPath: newFolder.path))

        // Verify selected items were moved inside
        XCTAssertTrue(FileManager.default.fileExists(atPath: newFolder.appendingPathComponent("docA.txt").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: newFolder.appendingPathComponent("docB.txt").path))

        // Verify unselected item remained in parent
        XCTAssertTrue(FileManager.default.fileExists(atPath: f3.path))
    }

    @MainActor
    func testBatchDuplicateAndCompress() async throws {
        let f1 = tempDir.appendingPathComponent("sample1.txt")
        let f2 = tempDir.appendingPathComponent("sample2.txt")
        try "1".write(to: f1, atomically: true, encoding: .utf8)
        try "2".write(to: f2, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        // Batch duplicate
        model.duplicate([f1, f2])
        try await Task.sleep(nanoseconds: 200_000_000)
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempDir.appendingPathComponent("sample1 - Copy.txt").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempDir.appendingPathComponent("sample2 - Copy.txt").path))

        // Batch compress
        model.compress([f1, f2])
        try await Task.sleep(nanoseconds: 400_000_000)
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempDir.appendingPathComponent("Archive.zip").path))
    }

    // MARK: - Archive & Conversion Tests
    @MainActor
    func testZipAndTarCompressionAndExtraction() async throws {
        let f1 = tempDir.appendingPathComponent("arch1.txt")
        let f2 = tempDir.appendingPathComponent("arch2.txt")
        try "Content 1".write(to: f1, atomically: true, encoding: .utf8)
        try "Content 2".write(to: f2, atomically: true, encoding: .utf8)

        // Test ZIP Compression
        let zipResult = FileOps.compress([f1, f2], in: tempDir, format: .zip)
        XCTAssertTrue(zipResult.errors.isEmpty, "Zip errors: \(zipResult.errors)")
        let zipArchive = tempDir.appendingPathComponent("Archive.zip")
        XCTAssertTrue(FileManager.default.fileExists(atPath: zipArchive.path))

        // Test ZIP Extraction to Subfolder
        let extractZipResult = FileOps.extract([zipArchive], in: tempDir, toSubfolder: true)
        XCTAssertTrue(extractZipResult.errors.isEmpty, "Extract zip errors: \(extractZipResult.errors)")
        let zipExtractedDir = tempDir.appendingPathComponent("Archive")
        XCTAssertTrue(FileManager.default.fileExists(atPath: zipExtractedDir.appendingPathComponent("arch1.txt").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: zipExtractedDir.appendingPathComponent("arch2.txt").path))

        // Test TAR GZIP Compression
        let tarResult = FileOps.compress([f1, f2], in: tempDir, format: .tarGz)
        XCTAssertTrue(tarResult.errors.isEmpty, "Tar errors: \(tarResult.errors)")
        let tarArchive = tempDir.appendingPathComponent("Archive.tar.gz")
        XCTAssertTrue(FileManager.default.fileExists(atPath: tarArchive.path))

        // Test TAR Extraction to Subfolder
        let extractTarResult = FileOps.extract([tarArchive], in: tempDir, toSubfolder: true)
        XCTAssertTrue(extractTarResult.errors.isEmpty, "Extract tar errors: \(extractTarResult.errors)")
        XCTAssertTrue(FileManager.default.fileExists(atPath: zipExtractedDir.appendingPathComponent("arch1.txt").path))
    }

    func testImageConversionsAndPDF() throws {
        // Create a solid color PNG image
        let rep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: 32,
            pixelsHigh: 32,
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bytesPerRow: 32 * 4,
            bitsPerPixel: 32
        )!
        let pngData = rep.representation(using: .png, properties: [:])!
        let imageURL = tempDir.appendingPathComponent("test_graphic.png")
        try pngData.write(to: imageURL)

        // Convert to JPEG
        let jpegResult = FileOps.convertImages([imageURL], to: .jpeg, in: tempDir)
        XCTAssertTrue(jpegResult.errors.isEmpty, "JPEG error: \(jpegResult.errors)")
        let jpegFile = tempDir.appendingPathComponent("test_graphic.jpg")
        XCTAssertTrue(FileManager.default.fileExists(atPath: jpegFile.path))

        // Convert to HEIC
        let heicResult = FileOps.convertImages([imageURL], to: .heic, in: tempDir)
        XCTAssertTrue(heicResult.errors.isEmpty, "HEIC error: \(heicResult.errors)")
        let heicFile = tempDir.appendingPathComponent("test_graphic.heic")
        XCTAssertTrue(FileManager.default.fileExists(atPath: heicFile.path))

        // Convert to TIFF
        let tiffResult = FileOps.convertImages([imageURL], to: .tiff, in: tempDir)
        XCTAssertTrue(tiffResult.errors.isEmpty, "TIFF error: \(tiffResult.errors)")
        let tiffFile = tempDir.appendingPathComponent("test_graphic.tiff")
        XCTAssertTrue(FileManager.default.fileExists(atPath: tiffFile.path))

        // Convert to PDF
        let pdfResult = FileOps.convertImages([imageURL], to: .pdf, in: tempDir)
        XCTAssertTrue(pdfResult.errors.isEmpty, "PDF error: \(pdfResult.errors)")
        let pdfFile = tempDir.appendingPathComponent("test_graphic.pdf")
        XCTAssertTrue(FileManager.default.fileExists(atPath: pdfFile.path))

        // Test Combining Multiple Images to PDF
        let imageURL2 = tempDir.appendingPathComponent("test_graphic_2.png")
        try pngData.write(to: imageURL2)
        let combineResult = FileOps.combineImagesToPDF([imageURL, imageURL2], in: tempDir)
        XCTAssertTrue(combineResult.errors.isEmpty, "Combine error: \(combineResult.errors)")
        let combinedPDF = tempDir.appendingPathComponent("Combined Images.pdf")
        XCTAssertTrue(FileManager.default.fileExists(atPath: combinedPDF.path))
    }

    func testDocumentConversions() throws {
        let docURL = tempDir.appendingPathComponent("report.txt")
        try "Pathway File Manager: Professional Document Conversion Test\nItem 1\nItem 2".write(to: docURL, atomically: true, encoding: .utf8)

        // Convert to DOCX
        let docxResult = FileOps.convertDocuments([docURL], to: .docx, in: tempDir)
        XCTAssertTrue(docxResult.errors.isEmpty, "DOCX error: \(docxResult.errors)")
        let docxFile = tempDir.appendingPathComponent("report.docx")
        XCTAssertTrue(FileManager.default.fileExists(atPath: docxFile.path))

        // Convert to RTF
        let rtfResult = FileOps.convertDocuments([docURL], to: .rtf, in: tempDir)
        XCTAssertTrue(rtfResult.errors.isEmpty, "RTF error: \(rtfResult.errors)")
        let rtfFile = tempDir.appendingPathComponent("report.rtf")
        XCTAssertTrue(FileManager.default.fileExists(atPath: rtfFile.path))

        // Convert to HTML
        let htmlResult = FileOps.convertDocuments([docURL], to: .html, in: tempDir)
        XCTAssertTrue(htmlResult.errors.isEmpty, "HTML error: \(htmlResult.errors)")
        let htmlFile = tempDir.appendingPathComponent("report.html")
        XCTAssertTrue(FileManager.default.fileExists(atPath: htmlFile.path))

        // Convert to PDF
        let pdfResult = FileOps.convertDocuments([docURL], to: .pdf, in: tempDir)
        XCTAssertTrue(pdfResult.errors.isEmpty, "PDF error: \(pdfResult.errors)")
        let pdfFile = tempDir.appendingPathComponent("report.pdf")
        XCTAssertTrue(FileManager.default.fileExists(atPath: pdfFile.path))
    }

    func testSymlinkSafetyInIsInside() throws {
        let folderA = tempDir.appendingPathComponent("FolderA")
        let folderB = folderA.appendingPathComponent("SubfolderB")
        try FileManager.default.createDirectory(at: folderB, withIntermediateDirectories: true)

        let symlinkToA = tempDir.appendingPathComponent("SymlinkA")
        try FileManager.default.createSymbolicLink(at: symlinkToA, withDestinationURL: folderA)

        // SubfolderB is inside FolderA
        XCTAssertTrue(FileOps.isInside(folderB, of: folderA))

        // SubfolderB resolved path is also inside SymlinkA
        XCTAssertTrue(FileOps.isInside(folderB, of: symlinkToA))

        // FolderA is NOT inside SubfolderB
        XCTAssertFalse(FileOps.isInside(folderA, of: folderB))
        XCTAssertFalse(FileOps.isInside(symlinkToA, of: folderB))
    }

    func testCodeAndNonUTF8DocumentConversions() throws {
        // Test Code File (Swift script) conversion to DOCX and PDF
        let swiftURL = tempDir.appendingPathComponent("AppMain.swift")
        try "import Foundation\nprint(\"Pathway Test\")\n".write(to: swiftURL, atomically: true, encoding: .utf8)

        let docxResult = FileOps.convertDocuments([swiftURL], to: .docx, in: tempDir)
        XCTAssertTrue(docxResult.errors.isEmpty, "Code to DOCX error: \(docxResult.errors)")
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempDir.appendingPathComponent("AppMain.docx").path))

        let pdfResult = FileOps.convertDocuments([swiftURL], to: .pdf, in: tempDir)
        XCTAssertTrue(pdfResult.errors.isEmpty, "Code to PDF error: \(pdfResult.errors)")
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempDir.appendingPathComponent("AppMain.pdf").path))

        // Test non-UTF8 text file (ISO-Latin-1 with accented characters)
        let latin1Data = Data([0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0xE9, 0x20, 0x57, 0x6F, 0x72, 0x6C, 0x64]) // "Hello é World"
        let latin1URL = tempDir.appendingPathComponent("latin1.txt")
        try latin1Data.write(to: latin1URL)

        let latin1PdfResult = FileOps.convertDocuments([latin1URL], to: .pdf, in: tempDir)
        XCTAssertTrue(latin1PdfResult.errors.isEmpty, "Latin1 to PDF error: \(latin1PdfResult.errors)")
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempDir.appendingPathComponent("latin1.pdf").path))
    }

    func testCorruptedArchiveAndEdgeCases() throws {
        // Fake / corrupted ZIP file
        let fakeZip = tempDir.appendingPathComponent("corrupt.zip")
        try "This is not a valid zip archive file.".write(to: fakeZip, atomically: true, encoding: .utf8)

        let extractResult = FileOps.extract([fakeZip], in: tempDir, toSubfolder: true)
        // Must handle failure gracefully without crashing and record an error
        XCTAssertFalse(extractResult.errors.isEmpty, "Expected error on corrupt zip")

        // Non-existent file compression edge case
        let nonExistent = tempDir.appendingPathComponent("does_not_exist.txt")
        let compressResult = FileOps.compress([nonExistent], in: tempDir, format: .zip)
        // Ditto returns error on non-existent source
        XCTAssertFalse(compressResult.errors.isEmpty)
    }

    @MainActor
    func testRenameValidationEdgeCases() async throws {
        let file = tempDir.appendingPathComponent("original_name.txt")
        try "Content".write(to: file, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        // Test illegal characters: slashes and colons
        model.renamingURL = file
        model.renameText = "invalid/name.txt"
        model.commitRename()
        XCTAssertNotNil(model.errorMessage)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))

        model.errorMessage = nil
        model.renamingURL = file
        model.renameText = "invalid:name.txt"
        model.commitRename()
        XCTAssertNotNil(model.errorMessage)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))

        // Test valid case-only rename
        model.errorMessage = nil
        model.renamingURL = file
        model.renameText = "Original_Name.txt"
        model.commitRename()
        try await Task.sleep(nanoseconds: 200_000_000)
        XCTAssertNil(model.errorMessage)
    }

    @MainActor
    func testUndoRedoStackOperations() async throws {
        let src = tempDir.appendingPathComponent("undo_test.txt")
        try "To be moved and undone".write(to: src, atomically: true, encoding: .utf8)

        let subDir = tempDir.appendingPathComponent("undo_dest")
        try FileManager.default.createDirectory(at: subDir, withIntermediateDirectories: true)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        // Move file into subfolder
        model.drop([src], into: subDir)
        try await Task.sleep(nanoseconds: 250_000_000)

        let movedFile = subDir.appendingPathComponent("undo_test.txt")
        XCTAssertTrue(FileManager.default.fileExists(atPath: movedFile.path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: src.path))
        XCTAssertTrue(model.canUndo)

        // Undo move
        model.undo()
        try await Task.sleep(nanoseconds: 350_000_000)

        // File should be back in original directory
        XCTAssertTrue(FileManager.default.fileExists(atPath: src.path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: movedFile.path))
    }

    @MainActor
    func testSearchFilterAndNavigation() async throws {
        let f1 = tempDir.appendingPathComponent("Apple.txt")
        let f2 = tempDir.appendingPathComponent("Banana.txt")
        let f3 = tempDir.appendingPathComponent("Apricot.txt")
        try "A".write(to: f1, atomically: true, encoding: .utf8)
        try "B".write(to: f2, atomically: true, encoding: .utf8)
        try "C".write(to: f3, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()
        XCTAssertEqual(model.displayItems.count, 3)

        // Filter search for "Ap"
        model.searchText = "Ap"
        XCTAssertEqual(model.displayItems.count, 2)
        let names = Set(model.displayItems.map(\.name))
        XCTAssertTrue(names.contains("Apple.txt"))
        XCTAssertTrue(names.contains("Apricot.txt"))
        XCTAssertFalse(names.contains("Banana.txt"))

        // Clear search
        model.searchText = ""
        XCTAssertEqual(model.displayItems.count, 3)

        // Navigation back & forward
        let sub = tempDir.appendingPathComponent("Sub")
        try FileManager.default.createDirectory(at: sub, withIntermediateDirectories: true)
        model.navigate(to: sub)
        XCTAssertEqual(model.currentURL.standardizedFileURL, sub.standardizedFileURL)
        XCTAssertTrue(model.canGoBack)

        model.goBack()
        XCTAssertEqual(model.currentURL.standardizedFileURL, tempDir.standardizedFileURL)
        XCTAssertTrue(model.canGoForward)

        model.goForward()
        XCTAssertEqual(model.currentURL.standardizedFileURL, sub.standardizedFileURL)
    }

    @MainActor
    func testFolderSizeCalculationAndFormatting() async throws {
        let parentFolder = tempDir.appendingPathComponent("ParentDir")
        let subFolder = parentFolder.appendingPathComponent("NestedSub")
        try FileManager.default.createDirectory(at: subFolder, withIntermediateDirectories: true)

        let file1 = parentFolder.appendingPathComponent("file1.dat")
        let file2 = subFolder.appendingPathComponent("file2.dat")
        try Data(repeating: 0x41, count: 1024 * 150).write(to: file1) // 150 KB
        try Data(repeating: 0x42, count: 1024 * 250).write(to: file2) // 250 KB

        // Calculate parent folder size via FolderSizeCalculator
        let calculated = await FolderSizeCalculator.shared.size(of: parentFolder)
        XCTAssertEqual(calculated, 1024 * 400) // 400 KB total

        // Verify FileItem size formatting
        let folderItem = FileItem(url: parentFolder, folderSize: calculated)
        XCTAssertTrue(folderItem.isFolder)
        XCTAssertEqual(folderItem.folderSize, 1024 * 400)
        XCTAssertEqual(folderItem.sizeSort, 1024 * 400)
        XCTAssertTrue(folderItem.displaySize.contains("KB") || folderItem.displaySize.contains("400"))

        // Empty folder should show "Zero bytes"
        let emptyFolder = tempDir.appendingPathComponent("EmptyDir")
        try FileManager.default.createDirectory(at: emptyFolder, withIntermediateDirectories: true)
        let emptyCalculated = await FolderSizeCalculator.shared.size(of: emptyFolder)
        XCTAssertEqual(emptyCalculated, 0)
        let emptyItem = FileItem(url: emptyFolder, folderSize: 0)
        XCTAssertEqual(emptyItem.displaySize, "Zero bytes")
    }

    @MainActor
    func testBrowserModelFolderSizeCalculationAndSorting() async throws {
        let parentDir = tempDir.appendingPathComponent("BrowserSizeTest")
        try FileManager.default.createDirectory(at: parentDir, withIntermediateDirectories: true)

        let smallFolder = parentDir.appendingPathComponent("SmallFolder")
        try FileManager.default.createDirectory(at: smallFolder, withIntermediateDirectories: true)
        try Data(repeating: 0x41, count: 1024 * 50).write(to: smallFolder.appendingPathComponent("file.bin")) // 50 KB

        let largeFolder = parentDir.appendingPathComponent("LargeFolder")
        try FileManager.default.createDirectory(at: largeFolder, withIntermediateDirectories: true)
        try Data(repeating: 0x42, count: 1024 * 500).write(to: largeFolder.appendingPathComponent("file.bin")) // 500 KB

        let emptyFolder = parentDir.appendingPathComponent("EmptyFolder")
        try FileManager.default.createDirectory(at: emptyFolder, withIntermediateDirectories: true)

        let model = FileBrowserModel(start: parentDir)
        // Wait for directory read and folder size calculations
        for _ in 0..<30 {
            if model.folderSizes.count >= 3 { break }
            try await Task.sleep(for: .milliseconds(50))
        }

        XCTAssertEqual(model.folderSizes.count, 3)
        XCTAssertEqual(model.folderSizes[smallFolder.path], 1024 * 50)
        XCTAssertEqual(model.folderSizes[largeFolder.path], 1024 * 500)
        XCTAssertEqual(model.folderSizes[emptyFolder.path], 0)

        guard let smallItem = model.displayItems.first(where: { $0.name == "SmallFolder" }),
              let largeItem = model.displayItems.first(where: { $0.name == "LargeFolder" }),
              let emptyItem = model.displayItems.first(where: { $0.name == "EmptyFolder" }) else {
            XCTFail("Missing folder items in displayItems")
            return
        }

        XCTAssertNotEqual(model.displaySize(for: smallItem), "—")
        XCTAssertTrue(model.displaySize(for: smallItem).contains("50") || model.displaySize(for: smallItem).contains("KB"))
        XCTAssertNotEqual(model.displaySize(for: largeItem), "—")
        XCTAssertTrue(model.displaySize(for: largeItem).contains("500") || model.displaySize(for: largeItem).contains("KB"))
        XCTAssertEqual(model.displaySize(for: emptyItem), "Zero bytes")

        // Test sorting by Size Descending
        model.setSort(.size)
        model.setSortDirection(ascending: false)
        XCTAssertEqual(model.displayItems.first?.name, "LargeFolder")

        // Test sorting by Size Ascending
        model.setSortDirection(ascending: true)
        XCTAssertEqual(model.displayItems.first?.name, "EmptyFolder")
    }

    @MainActor
    func testSortByAllFieldsAndAscendingDescending() async throws {
        let f1 = tempDir.appendingPathComponent("A_small.txt")
        let f2 = tempDir.appendingPathComponent("Z_large.txt")
        try Data(repeating: 0x31, count: 100).write(to: f1)
        try Data(repeating: 0x32, count: 5000).write(to: f2)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        // Sort by Name Ascending
        model.setSort(.name)
        model.setSortDirection(ascending: true)
        XCTAssertEqual(model.currentSortField, .name)
        XCTAssertTrue(model.sortAscending)
        XCTAssertEqual(model.displayItems.first?.name, "A_small.txt")

        // Sort by Name Descending
        model.setSortDirection(ascending: false)
        XCTAssertFalse(model.sortAscending)
        XCTAssertEqual(model.displayItems.first?.name, "Z_large.txt")

        // Sort by Size Ascending
        model.setSort(.size)
        model.setSortDirection(ascending: true)
        XCTAssertEqual(model.currentSortField, .size)
        XCTAssertEqual(model.displayItems.first?.name, "A_small.txt")

        // Sort by Size Descending
        model.setSortDirection(ascending: false)
        XCTAssertEqual(model.displayItems.first?.name, "Z_large.txt")

        // Sort by Kind / Type
        model.setSort(.kind)
        XCTAssertEqual(model.currentSortField, .kind)

        // Sort by Date Modified
        model.setSort(.modified)
        XCTAssertEqual(model.currentSortField, .modified)

        // Sort by Date Created
        model.setSort(.created)
        XCTAssertEqual(model.currentSortField, .created)

        // Sort by Tags
        model.setSort(.tags)
        XCTAssertEqual(model.currentSortField, .tags)
    }

    @MainActor
    func testGroupByKindDateSizeAndTags() async throws {
        let folder = tempDir.appendingPathComponent("ProjectsFolder")
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)

        let image = tempDir.appendingPathComponent("photo.png")
        try "fake_image".write(to: image, atomically: true, encoding: .utf8)

        let doc = tempDir.appendingPathComponent("notes.txt")
        try "fake_notes".write(to: doc, atomically: true, encoding: .utf8)

        let zip = tempDir.appendingPathComponent("bundle.zip")
        try "fake_zip".write(to: zip, atomically: true, encoding: .utf8)

        let model = FileBrowserModel(start: tempDir)
        await model.reload()

        // None grouping: should return single group with no title
        model.groupBy = .none
        XCTAssertEqual(model.groupedItems.count, 1)
        XCTAssertEqual(model.groupedItems[0].title, "")

        // Group by Kind / Type
        model.groupBy = .kind
        let kindGroups = model.groupedItems
        let groupTitles = Set(kindGroups.map(\.title))
        XCTAssertTrue(groupTitles.contains("Folders"))
        XCTAssertTrue(groupTitles.contains("Images"))
        XCTAssertTrue(groupTitles.contains("Documents") || groupTitles.contains("Other Files"))
        XCTAssertTrue(groupTitles.contains("Archives"))

        // Group by Date
        model.groupBy = .dateModified
        let dateGroups = model.groupedItems
        XCTAssertFalse(dateGroups.isEmpty)

        // Group by Size
        model.groupBy = .size
        let sizeGroups = model.groupedItems
        XCTAssertFalse(sizeGroups.isEmpty)

        // Group by Tags
        model.toggleTag("Blue", for: [image])
        await model.reload()
        model.groupBy = .tags
        let tagGroups = model.groupedItems
        let tagTitles = Set(tagGroups.map(\.title))
        XCTAssertTrue(tagTitles.contains("Blue"))
        XCTAssertTrue(tagTitles.contains("No Tags"))
    }
}



