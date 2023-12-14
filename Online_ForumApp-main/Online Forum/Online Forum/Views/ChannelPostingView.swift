//
//  ChannelPostingView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//
//



import SwiftUI

struct ChannelPostingView: View {
    @Binding var isPresented: Bool
    @State private var channelName: String = ""
    @State private var channelDescription: String = ""
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @ObservedObject var dataStore: DataStore

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Channel Details")) {
                    TextField("Channel Name", text: $channelName)
                    TextField("Description", text: $channelDescription)
                }

                Section(header: Text("Channel Image")) {
                    HStack {
                        if let selectedImage = image {
                            selectedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("Select an image")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button("Choose Image") {
                            showingImagePicker = true
                        }
                    }
                }
            }
            .navigationBarTitle("Create New Channel", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            }, trailing: Button("Create") {
                if let unwrappedImage = inputImage {
                    if let imageName = dataStore.saveImage(unwrappedImage) {
                        dataStore.addChannel(name: channelName, description: channelDescription, imageName: imageName)
                    }
                }
                isPresented = false
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

// Preview for ChannelPostingView
struct ChannelPostingView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelPostingView(isPresented: .constant(true), dataStore: DataStore())
    }
}
