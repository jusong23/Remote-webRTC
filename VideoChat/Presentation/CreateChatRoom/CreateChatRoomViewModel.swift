//
//  CreateChatRoomViewModel.swift
//  VideoChat
//
//  Created by jusong on 3/26/24.
//

import Foundation
import SwiftUI

class CreateChatRoomViewModel: ObservableObject {
    private let videoChatRepository = VideoChatRepository()
    
    func createChatRoom(chatRoomName: String) async throws -> String {
        try await videoChatRepository.createChatRoom(chatRoomName: chatRoomName)
    }
}
