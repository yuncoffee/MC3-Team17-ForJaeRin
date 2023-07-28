//
//  KeywordFieldView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct KeywordFieldView: View {
    /// 텍스트필드의 키워드 전달
    @Binding var newKeyword: String
    /// 찐한 색 !
    @State var colorDeep = false
    /// textField or text
    @State var availableEdit = false
    /// focus 조절
    @FocusState private var focusedField: Bool
    /// cursor의 index와 텍스트필드의 인덱스가 동일한지 확인
    var cursorIndex: Int
    var index: Int
    /// 수정중인지 넘김
    @Binding var editSomething: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
//            if cursorIndex == index {
//                Rectangle()
//                    .frame(width: 2, height: 60)
//                    .foregroundColor(Color.blue)
//            }
//            if availableEdit || newKeyword.isEmpty {
//                Text(newKeyword == "" ? "키워드 입력" : newKeyword1)
//                    .systemFont(.subTitle)
//                    .border(.blue)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 12)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 5)
//                            .inset(by: 0.5)
//                            .stroke(!colorDeep ? Color.systemGray100 : Color.systemPrimary, lineWidth: 1)
//                            .background(!colorDeep ? .clear : Color.primary100)
//                    )
                TextField("키워드 입력", text: $newKeyword
//                          onEditingChanged: { isEditing in
//                              if isEditing {
//                                  editSomething = true
//                                  focusedField = true
//                                  availableEdit = true
//                                  colorDeep = true
//                              } else {
//                                  // print("지금 !")
//                                  colorDeep = false
//                                  editSomething = false
//                                  availableEdit = false
//                              }
//                }
                )
                .fixedSize()
                .focused($focusedField)
                .textFieldStyle(PlainTextFieldStyle())
//                .systemFont(.subTitle)
                .foregroundColor(Color(red: 0.54, green: 0.43, blue: 1))
                .border(.red)
//            } else {
//                Text("\(newKeyword)")
//                    .systemFont(.subTitle)
//                    .foregroundColor(Color.systemPrimary)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 12)
//                    .fixedSize()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 5)
//                            .inset(by: 0.5)
//                            .stroke(!colorDeep ? Color.systemGray100 : Color.systemPrimary, lineWidth: 1)
//                            .background(!colorDeep ? .clear : Color.primary100)
//                    )
//                    .onTapGesture(count: 2) {
//                        focusedField = true
//                        editSomething = true
//                        colorDeep = true
//                        availableEdit = true
//                    }
//            }
        }.frame(height: 54)
    }
}
