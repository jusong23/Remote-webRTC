//
//  CreateChatRoom.swift
//  VideoChat
//
//  Created by Grzegorz Baczek on 20/11/2022.
//

import Foundation
import SwiftUI

struct CreateChatRoomView: View {
    
    @State var chatRoomName: String = ""
    @State var errorMessage: String = ""
    @State var creatingChatRoom: Bool = false
    @State var roomId: String = ""
    @StateObject var createChatRoomViewModel = CreateChatRoomViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Chat room name", text: $chatRoomName , prompt: Text("Enter chat room name"))
            Text(errorMessage)
                .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                NavigationLink(
                    "",
                    destination: ParticipantView(
                        viewModel: ParticipantViewModel(
                            chatRoomId: roomId,
                            currentPeer: WebRTCManager.peer.host
                        )
                    )
                    .navigationTitle("Host \(chatRoomName)")
                    ,
                    isActive: Binding<Bool>(
                        get: {
                            roomId != ""
                        },
                        set: { value in
                            if !value {
                                roomId = ""
                                chatRoomName = ""
                            }
                        }
                    )
                )
                Button("Next", action: {
                    creatingChatRoom = true
                    Task {
                        errorMessage = ""
                        do {
                            roomId = try await createChatRoomViewModel.createChatRoom(chatRoomName: chatRoomName)
                        }
                        catch {
                            errorMessage = error.localizedDescription
                        }
                    }
                    creatingChatRoom = false
                })
                .disabled(chatRoomName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || roomId != "")
            }
        }
        .padding([.trailing, .leading, .bottom], 32)
    }
}
