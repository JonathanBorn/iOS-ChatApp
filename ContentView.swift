//
//  ContentView.swift
//  ChatApp2
//
//  Created by Jonathan Born on 2022-04-01.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12")
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct Home : View {
    
    @State var show = false
    
    var body: some  View{
        
        NavigationView {
            ZStack {
                NavigationLink(destination: SignupView(show: self.$show), isActive: self.$show) {
                    Text("")
                }
                .hidden()
                
                LoginView(show: self.$show)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct LoginView: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass  = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader {_ in
                    
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(40)
                            .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color.black, lineWidth: 4))
                        
                        
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? .black : self.color, lineWidth: 2))
                            .padding(.top, 25)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        HStack (spacing: 15){
                            VStack {
                                if self.visible {
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button {
                                self.visible.toggle()
                            } label: {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? .black : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Forgot Password")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(.top, 20)
                        
                        Button {
                            self.verify()
                        } label: {
                            Text("Log In")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 130)
                }
                
                Button {
                    self.show.toggle()
                } label: {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding()
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func verify() {
        if self.email != "" && self.pass != "" {
            
        } else {
            self.error = "Please fill out all fields"
            self.alert.toggle()
        }
    }
}


struct SignupView: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass  = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            GeometryReader {_ in
                
                VStack {
                    
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(40)
                        .overlay(RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 4))
                    
                    Text("Create your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 35)
                    
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? .black : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    HStack (spacing: 15){
                        VStack {
                            if self.visible {
                                TextField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button {
                            self.visible.toggle()
                        } label: {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? .black : self.color, lineWidth: 2))
                    .padding(.top, 25)
                    
                    HStack (spacing: 15){
                        VStack {
                            if self.visible {
                                TextField("Re-Password", text: self.$repass)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Re-Password", text: self.$repass)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button {
                            self.revisible.toggle()
                        } label: {
                            Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? .black : self.color, lineWidth: 2))
                    .padding(.top, 25)
                    
                    Button {
                        CreateAccount()
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.top, 25)
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 130)
            }
            
            Button(action: {
                self.show.toggle()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title)
                    
                    Text("Log In")
                        .fontWeight(.bold)
                }
                .foregroundColor(.black)
            }
            .padding()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func CreateAccount() {
        Auth.auth().createUser(withEmail: email, password: pass) { result, error in
            if let error = error {
                print("Failed to create user \(error)")
            }
            
            
            
            print("Successfully created user \(String(describing: result?.user.uid))")
        }
    }
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View {
        
        GeometryReader {_ in
            
            VStack {
                
                Text("Error")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(self.color)
                    .padding(.horizontal, 25)
                
                Text(self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                Button(action: {
                    self.alert.toggle()
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(.black)
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(.white)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
