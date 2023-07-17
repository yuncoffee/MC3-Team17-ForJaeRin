//
//  ForJaeRinApp.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

@main
struct ForJaeRinApp: App {
    var body: some Scene {

        @StateObject var projectFileManager = ProjectFileManager()
        
        Window("Home", id: "Home") {
            VStack {
                TestWindowButtonView()
                TestWindowButtonView2(documentURL: AppFileManager.shared.documentUrl)
            }
        }

        DocumentGroup(newDocument: {KkoDocument()}, editor: { _ in ProjectDocumentView()})
        
//        WindowGroup(id: "Book Details") {
////            FileSystemView()
////            RecordView()
//            ContentView()
//                .toolbarBackground(Color.systemWhite)
//                .environmentObject(ProjectFileManager())
//        }
//        .commands {
//            ToolbarCommands()
//        }
//        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
    }
}

struct TestWindowButtonView: View {
    @Environment(\.newDocument) private var newDocument

    var body: some View {
        Button("Open Activity Window") {
            newDocument({KkoDocument()})
        }
    }
}

struct TestWindowButtonView2: View {
    var documentURL: URL
    @Environment(\.openDocument) private var openDocument

    var body: some View {
        Button("Open Document") {
           Task {
               do {
                   try await openDocument(at: documentURL)
               } catch {
                   // Handle error
               }
           }
       }
    }
}
