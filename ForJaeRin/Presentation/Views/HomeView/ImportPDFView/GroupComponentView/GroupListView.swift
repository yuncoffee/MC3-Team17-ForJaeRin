//
//  GroupListView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct GroupListView: View {
    /// ellipsis를 누르면 tempData에 저장한다.
    /// groupIndex는 -1로 초기화해둔다.
    /// 취소 버튼 -> tempData로 접근
    /// 완료 버튼 -> 새로 입력된 데이터로 접근
    /// 휴지통 버튼 -> 삭제
    /// 새로 추가할 때
    /// 취소 버튼 -> 삭제
    /// 완료 버튼 -> 저장
    /// 휴지통 버튼 -> 생성 안됨
    ///
    @ObservedObject var vm: SettingGroupVM
    var index: Int
    /// 해당 그룹 리스트뷰가 수정중인지(최초 제작 혹은 ellipsis를 통해 활성화됨
    @State var editMode = true
    @State var isExpanded = false
    /// editMode가 켜지면 true, trash.fill 혹은 입력을 모두 하지 않고 취소를 누르면 false
    @State var tempData = ["", "", "", "-1", "-1"]
    @FocusState var focusField: Bool
    @State var onDelete = false
    @EnvironmentObject var myData: MyData
    var resetAction: () -> Void
    
    var body: some View {
        if index < myData.groupData.count {
            if editMode {
                VStack(alignment: .center) {
                    HStack(spacing: 4) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.black.opacity(0.01))
                                .frame(width: myData.groupData[index][0] != ""
                                       && myData.groupData[index][1] != ""
                                       && myData.groupData[index][2] != ""
                                       && myData.groupData[index][3] != "-1"
                                       && myData.groupData[index][4] != "-1"
                                       && tempData != ["", "", "", "-1", "-1"]
                                       ? 141 : 173,
                                        height: 36)
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.black.opacity(0.04), lineWidth: 1)
                                .frame(width: myData.groupData[index][0] != ""
                                       && myData.groupData[index][1] != ""
                                       && myData.groupData[index][2] != ""
                                       && myData.groupData[index][3] != "-1"
                                       && myData.groupData[index][4] != "-1"
                                       && tempData != ["", "", "", "-1", "-1"]
                                       ? 141 : 173,
                                        height: 36)
                            TextField("그룹이름을 입력해주세요", text: $myData.groupData[index][0])
                                .focused($focusField)
                                .font(.system(size: 14))
                                .textFieldStyle(.plain)
                                .padding(.leading, 10)
                        }.frame(width: myData.groupData[index][0] != ""
                                && myData.groupData[index][1] != ""
                                && myData.groupData[index][2] != ""
                                && myData.groupData[index][3] != "-1"
                                && myData.groupData[index][4] != "-1"
                                && tempData != ["", "", "", "-1", "-1"]
                                ? 141 : 173,
                                height: 36)
                        /// 입력받은 데이터가 모두 있고, tempData가 ["", "", "", "", ""]가 아니어야 trash.fill을 표시
                        if myData.groupData[index][0] != ""
                            && myData.groupData[index][1] != ""
                            && myData.groupData[index][2] != ""
                            && myData.groupData[index][3] != "-1"
                            && myData.groupData[index][4] != "-1"
                            && tempData != ["", "", "", "-1", "-1"] {
                            Button(action: {
                                focusField = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    withAnimation {
                                        myData.groupData.remove(at: index)
                                        resetAction()
                                        editMode = false
                                        vm.somethingIsEdit = false
                                        vm.focusGroup = -1
                                        tempData = ["", "", "", "-1", "-1"]
                                    }
                                }
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(Color.systemGray300)
                            }).buttonStyle(.plain)
                        }
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.black.opacity(0.01))
                            .frame(width: 173, height: 76)
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.black.opacity(0.04), lineWidth: 1)
                            .frame(width: 173, height: 76)
                        VStack {
                            HStack(spacing: 0) {
                                Text("발표 시간")
                                    .font(.system(size: 14))
                                    .padding(.leading, 9)
                                Spacer()
                                TextField("0", text: $myData.groupData[index][1])
                                    .focused($focusField)
                                    .font(.system(size: 14))
                                    .textFieldStyle(.plain)
                                    .frame(width: 17)
                                Text("분")
                                    .font(.system(size: 14))
                                TextField("0", text: $myData.groupData[index][2])
                                    .focused($focusField)
                                    .font(.system(size: 14))
                                    .textFieldStyle(.plain)
                                    .frame(width: 17)
                                Text("초")
                                    .onTapGesture {
                                        print(myData.groupData)
                                        print(tempData)
                                        focusField = false
                                    }
                                    .font(.system(size: 14))
                                    .padding(.trailing, 9)
                            }
                            HStack {
                                Text("페이지 번호")
                                    .font(.system(size: 14))
                                    .padding(.leading, 9)
                                Spacer()
                                Text("\(Int(myData.groupData[index][3])! + 1) - \(Int(myData.groupData[index][4])! + 1)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black.opacity(0.25))
                                    .padding(.trailing, 9)
                            }
                        }
                    }.frame(width: 173, height: 76)
                    HStack {
                        /// 입력받지 않은 데이터가 하나라도 있다면 groupData에서 remove
                        Button(action: {
                            focusField = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                withAnimation {
                                    myData.groupData.remove(at: index)
                                    editMode = false
                                    vm.somethingIsEdit = false
                                    vm.focusGroup = -1
                                    if tempData[0] != ""
                                        || tempData[1] != ""
                                        || tempData[2] != ""
                                        || tempData[3] != "-1"
                                        || tempData[4] != "-1" {
                                        var answerIndex = 0
                                        for alreadyData in myData.groupData {
                                            if Int(alreadyData[3])! > Int(tempData[3])! {
                                                break
                                            }
                                            answerIndex += 1
                                        }
                                        myData.groupData.insert(tempData, at: answerIndex)
                                    }
                                    resetAction()
                                    tempData = ["", "", "", "-1", "-1"]
                                    print(myData.groupData)
                                }
                            }
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(red: 0.18, green: 0.18, blue: 0.18).opacity(0.25))
                                    .frame(width: 75, height: 38)
                                Text("취소")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.white)
                            }
                        }).buttonStyle(.plain)
                        /// 입력받지 않은게 하나라도 있으면 disabled
                        Button(action: {
                            withAnimation {
                                var answerIndex = 0
                                let addedData = myData.groupData[index]
                                myData.groupData.remove(at: index)
                                for alreadyData in myData.groupData {
                                    if Int(alreadyData[3])! > Int(addedData[3])! {
                                        break
                                    }
                                    answerIndex += 1
                                }
                                myData.groupData.insert(addedData, at: answerIndex)
                                editMode = false
                                vm.focusGroup = -1
                                vm.somethingIsEdit = false
                                resetAction()
                                tempData = ["", "", "", "-1", "-1"]
                            }
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(red: 0.54, green: 0.43, blue: 1))
                                    .frame(width: 75, height: 38)
                                Text("완료")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.white)
                            }
                        }).buttonStyle(.plain)
                            .disabled(
                                myData.groupData[index][0] == ""
                                    || myData.groupData[index][1] == ""
                                    || myData.groupData[index][2] == ""
                                    || myData.groupData[index][3] == "-1"
                                    || myData.groupData[index][4] == "-1"
                            )
                    }
                }
            } else {
                DisclosureGroup(isExpanded: $isExpanded, content: {
                    HStack {
                        Text("발표 시간")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size: 12))
                            .padding(.leading, 12)
                        
                        Spacer()
                        Text("\(myData.groupData[index][1])분 \(myData.groupData[index][2])초")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .padding(.trailing, 24)
                    }.padding(.top, 13)
                    HStack {
                        Text("페이지 번호")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size: 12))
                            .padding(.leading, 12)
                        Spacer()
                        Text("\(Int(myData.groupData[index][3])! + 1) - \(Int(myData.groupData[index][4])! + 1)")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .padding(.trailing, 24)
                    }.padding(.top, 16)
                    
                }, label: {
                    HStack {
                        Text("\(myData.groupData[index][0])")
                            .foregroundColor(.black.opacity(0.85))
                            .font(.system(size: 14))
                            .padding(.leading, 8)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                editMode = true
                                vm.somethingIsEdit = true
                                vm.focusGroup = index
                                tempData = myData.groupData[index]
                                for dataIndex in 0..<vm.groupIndex.count {
                                    if vm.groupIndex[dataIndex] == index {
                                        vm.groupIndex[dataIndex] = -1
                                    }
                                }
                            }
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 23, height: 33)
                                .padding(.trailing, 20)
                        }).buttonStyle(.plain)
                }
                })
                .padding(.leading, 12)
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.85))
                .accentColor(Color.green)
            }
        }
    }
}
