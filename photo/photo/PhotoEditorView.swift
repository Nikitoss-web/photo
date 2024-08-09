import SwiftUI
import PencilKit

struct PhotoEditorView: View {
    @StateObject private var viewModel = PhotoEditorViewModel()
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var textToAdd = ""
    @State private var selectedText: EditableText?
    @State private var selectedTextAttributes = TextAttributes(size: 40, color: .red)
    @State private var scale: CGFloat = 1.0
    @GestureState private var magnification: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let editedImage = viewModel.imageModel?.editedImage {
                    ZStack {
 
                        
                        ForEach(viewModel.texts) { text in
                            Text(text.content)
                                .font(.system(size: text.attributes.size))
                                .foregroundColor(text.attributes.color)
                                .position(text.position)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            viewModel.updateTextPosition(id: text.id, position: value.location)
                                        }
                                )
                                .onTapGesture {
                                    selectedText = text
                                    selectedTextAttributes = text.attributes
                                    textToAdd = text.content
                                }
                        }
                        
                        DrawingView(drawing: $viewModel.drawing)
                            .background(Color.white)
                            .padding()
                        ScalableImageView(image: .constant(editedImage))
                            .border(Color.black, width: 1)
                            .padding()
                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                            .scaleEffect(scale * magnification)
                            .gesture(
                                MagnificationGesture()
                                    .updating($magnification) { value, state, _ in
                                        state = value
                                    }
                                    .onEnded { value in
                                        scale *= value
                                    }
                            )
                        
                        if selectedText != nil {
                            VStack {
                                TextField("Enter text to add", text: $textToAdd)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .background(Color.white)
                                    .frame(maxWidth: .infinity)
                                
                                Slider(value: $selectedTextAttributes.size, in: 10...100, step: 1) {
                                    Text("Text Size")
                                }
                                .padding()
                                
                                ColorPicker("Text Color", selection: $selectedTextAttributes.color)
                                    .padding()
                                
                                Button("Apply Changes") {
                                    if let selectedText = selectedText {
                                        viewModel.updateTextAttributes(id: selectedText.id, attributes: selectedTextAttributes)
                                        self.selectedText = nil
                                    }
                                }
                                .padding()
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                        }
                    }
                    
                    Button("Add Text") {
                        let attributes = TextAttributes(size: 40, color: .red)
                        viewModel.addText(content: textToAdd, position: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4), attributes: attributes)
                        textToAdd = ""
                    }
                    .padding()
                    
                    Button("Apply Sepia Filter") {
                        viewModel.applyFilter("CISepiaTone")
                    }
                    .padding()
                    
                    Button("Save Image") {
                        viewModel.saveImage()
                    }
                } else {
                    Text("No Image Selected")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .padding()
                }
                
                if viewModel.imageModel == nil {
                    HStack {
                        Button(action: {
                            sourceType = .photoLibrary
                            showImagePicker = true
                        }) {
                            Text("Select from Library")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            sourceType = .camera
                            showImagePicker = true
                        }) {
                            Text("Take a Photo")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: sourceType) { image in
                    if let image = image {
                        viewModel.loadImage(image: image)
                    }
                }
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(
                    title: Text(alertItem.title),
                    message: Text(alertItem.message),
                    dismissButton: .default(Text("OK"))
                )
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .padding()
                    }
                }
            )
            .padding()
        }
    }
}

struct PhotoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditorView()
    }
}
