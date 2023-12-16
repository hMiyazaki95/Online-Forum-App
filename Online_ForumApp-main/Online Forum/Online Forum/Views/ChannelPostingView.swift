//
//  ChannelPostingView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//
//




import SwiftUI
import UIKit

struct ChannelPostingView: View {
    @ObservedObject var dataStore: DataStore
    @State private var channelName: String = ""
    @State private var channelDescription: String = ""
    @State private var isShowingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var nameExists: Bool = false
    @State private var isTextFieldFocused: Bool = false

    @Binding var isPresented: Bool
    @Binding var channelCreated: Bool

    var body: some View {
        VStack {
            TextField("Channel Name", text: $channelName) { isEditing in
                isTextFieldFocused = isEditing
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .onChange(of: channelName, initial: false) { oldName, newName in
                // You now have access to both oldName and newName
                nameExists = dataStore.channels.contains {
                    $0.name.lowercased() == newName.lowercased()
                }
            }


            if isTextFieldFocused {
                List {
                    ForEach(filteredChannels.prefix(5), id: \.id) { channel in
                        Text(channel.name).onTapGesture {
                            self.channelName = channel.name
                            self.isTextFieldFocused = false
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }

            TextField("Description", text: $channelDescription)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

            
            Button("Select Image") {
                isShowingImagePicker = true
            }
            .buttonStyle(CommonButtonStyle()) // Correctly applying the button style
            .padding(.bottom)

            if let image = inputImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
            }

            if nameExists {
                Text("Channel name already exists")
                    .foregroundColor(.red)
            }

            Button("Create Channel") {
                handleChannelCreation()
            }
            .disabled(channelName.isEmpty || inputImage == nil || nameExists)
            .buttonStyle(GreenButton()) // Applying the green color here
            .padding(.bottom)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Create New Channel")
        .sheet(isPresented: $isShowingImagePicker) {
            CustomImagePicker(image: $inputImage)
        }
    }

    private var filteredChannels: [Channel] {
        guard !channelName.isEmpty else { return [] }
        return dataStore.channels.filter { $0.name.lowercased().contains(channelName.lowercased()) }
    }

    private func handleChannelCreation() {
        guard let inputImage = inputImage, !channelName.isEmpty else { return }
        if let imageName = dataStore.saveImage(inputImage) {
            let newChannel = Channel(id: UUID(), name: channelName, description: channelDescription, image: imageName, posts: [])
            dataStore.channels.append(newChannel)
            // Reset form fields
            channelName = ""
            channelDescription = ""
            self.inputImage = nil
            nameExists = false
            // Indicate channel creation was successful
            channelCreated = true
        }
    }
}
struct CustomImagePicker: UIViewControllerRepresentable {
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
        var parent: CustomImagePicker

        init(_ parent: CustomImagePicker) {
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
