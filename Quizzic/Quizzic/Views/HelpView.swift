//
//  HelpView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 18/7/2023.
//

import SwiftUI
import PDFKit


// HelpView displays the user manual PDF using PDFKit.
struct HelpView: View {
    let pdfUrl = Bundle.main.url(forResource: "UserManual", withExtension: "pdf")! // URL for the user manual PDF file.
    
    var body: some View {
        PDFKitView(url: pdfUrl) // Display the PDF using PDFKitView.
            .padding()
    }
}

// PDFKitView represents a UIView displaying a PDF document using PDFKit.
struct PDFKitView: UIViewRepresentable {
    let url: URL // The URL of the PDF document to be displayed.
    
    // Create and configure a PDFView with the given URL.
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        let pdfView = PDFView() // Create a new PDFView.
        pdfView.document = PDFDocument(url: self.url) // Add the PDF document to the PDFView.
        return pdfView
    }
    
    // Update the PDFView when necessary (not used in this implementation).
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
    }
}
