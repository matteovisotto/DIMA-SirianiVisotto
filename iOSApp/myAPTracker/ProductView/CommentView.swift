//
//  CommentView.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct CommentView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    if((viewModel.comments?.numberOfComments ?? 0) == 0 && !viewModel.commentLoading){
                        Text("No comments available")
                    } else {
                        
                        ForEach(0..<(viewModel.comments?.numberOfComments ?? 0), id: \.self){ index in
                            if(index == 0){
                                CommentCell(comment: viewModel.comments!.comments[index], isFirst: true) {
                                    EditCommentAlertViewController.present(comment: viewModel.comments!.comments[index].comment) { comment in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            viewModel.updateComment(cId: viewModel.comments!.comments[index].id, text: comment)
                                        }
                                    }
                                    
                                } onDelete: {
                                    viewModel.deleteComment(cId: viewModel.comments!.comments[index].id)
                                }
                            } else {
                                CommentCell(comment: viewModel.comments!.comments[index]){
                                    EditCommentAlertViewController.present(comment: viewModel.comments!.comments[index].comment) { comment in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            viewModel.updateComment(cId: viewModel.comments!.comments[index].id, text: comment)
                                        }
                                    }
                                } onDelete: {
                                    viewModel.deleteComment(cId: viewModel.comments!.comments[index].id)
                                }
                            }
                            
                        }
                        
                    }
                }
                if(appState.isUserLoggedIn){
                    HStack{
                        IconTextField(titleKey: "Add new comment", text: $viewModel.newCommentText, icon: nil, foregroundColor: Color("PrimaryLabel"), showValidator: false).accessibilityIdentifier("CommentViewCommentTextField")
                        Button{
                            viewModel.createComment()
                        } label: {
                            Image(systemName: "paperplane").foregroundColor(Color("PrimaryLabel"))
                        }
                    }
                }
            }
            if(viewModel.commentLoading){
                VStack{
                    LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct CommentCell: View{
    var comment: Comment
    var isFirst: Bool = false
    var onEdit: () -> ()
    var onDelete: () -> ()
    
    var body: some View {
        VStack(spacing: 0){
            if(!isFirst){
                Rectangle().fill(Color("PrimaryLabel").opacity(0.6)).frame(height: 1).padding(.bottom, 5)
            }
            VStack(alignment: .leading, spacing: 2.5){
                HStack{
                    UserWebImage("https://avatars.dicebear.com/api/initials/"+Utils.getInitialFromComment(comment)+".png").frame(width: 25, height: 25).cornerRadius(12.5)
                    Text(comment.username).font(.caption).foregroundColor(Color("PrimaryLabel").opacity(0.8))
                    if(AppState.shared.isUserLoggedIn && comment.userId == AppState.shared.userIdentity?.id){
                        Spacer()
                        Menu {
                            Button {
                                onEdit()
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button {
                                onDelete()
                            } label: {
                                Label("Delete", systemImage: "trash").foregroundColor(Color.red)
                            }
                            
                        } label: {
                            Image(systemName: "ellipsis").foregroundColor(Color("PrimaryLabel"))
                        }
                        
                        
                    }
                }.padding(.bottom, 5)
                Text(comment.comment).font(Font.body).foregroundColor(Color("PrimaryLabel"))
                HStack{
                    Spacer()
                    Text(comment.publishedAt.components(separatedBy: " ")[0]).font(.caption).foregroundColor(Color("PrimaryLabel").opacity(0.8))
                }
            }
        }
    }
}

