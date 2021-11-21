//
//  CreateEventView.swift
//  AmericanSpace App
//
//  Created by Darkhan on 30.04.2021.
//

import SwiftUI

struct CreateEventView: View {
    
    @StateObject var viewModel = EventViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Type title here", text: $viewModel.event.title)
                }
                Section(header: Text("Description")) {
                    TextField("Type description here", text: $viewModel.event.description )
                }
            }
            .navigationBarTitle("New Event", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { handleCancelTapped() }, label: {Text("Cancel")}),
                trailing: Button(action: { handleDoneTapped() }, label: {Text("Done")})
                    .disabled(!viewModel.modified)
            )
            
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        viewModel.saveEvent()
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
