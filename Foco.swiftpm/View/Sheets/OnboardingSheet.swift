//
//  OnboardingSheet.swift
//
//
//  Created by João Franco on 10/02/2024.
//

import SwiftUI

struct OnboardingSheet: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Image("foco_logo")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Text("Welcome to Foco")
                    .font(.system(.largeTitle, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 52)
                
                Spacer()
                NavigationLink(destination: OnboardingSheetPage2()) {
                    Text("Next")
                        .font(.system(.callout, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .foregroundColor(.white)
                        .background(Color(red: 237/255, green: 106/255, blue: 208/255))
                        .mask { RoundedRectangle(cornerRadius: 16, style: .continuous) }
                        .padding(.bottom)
                }
            }
            .padding(.horizontal, 29)
            .padding(.vertical)
            .background {
                LinearGradient(gradient: Gradient(colors: [.clear, Color(red: 237/255, green: 106/255, blue: 208/255).opacity(0.25)]), startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
        }
        .interactiveDismissDisabled()
    }
}

struct OnboardingSheetPage2: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Image(systemName: "flame.fill")
                    .renderingMode(.original)
                    .foregroundStyle(Color(red: 237/255, green: 106/255, blue: 208/255))
                    .font(.system(size: 60))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Text("More than Half of Students experience academic burnout")
                    .font(.system(.largeTitle, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Text("According to recent research, over 50% of college students experience academic burnout, compromising their mental well-being and academic success.")
                    .font(.system(.callout, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom, 52)
                
                Spacer()
                NavigationLink(destination: OnboardingSheetPage3()) {
                    Text("Next")
                        .font(.system(.callout, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .foregroundColor(.white)
                        .background(Color(red: 237/255, green: 106/255, blue: 208/255))
                        .mask { RoundedRectangle(cornerRadius: 16, style: .continuous) }
                        .padding(.bottom)
                }
            }
            .padding(.horizontal, 29)
            .padding(.vertical)
            .background {
                LinearGradient(gradient: Gradient(colors: [.clear, Color(red: 237/255, green: 106/255, blue: 208/255).opacity(0.25)]), startPoint: .top, endPoint: .bottom)
            }
            .interactiveDismissDisabled()
        }
        .ignoresSafeArea()
    }
}

struct OnboardingSheetPage3: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Image(systemName: "brain.fill")
                    .renderingMode(.original)
                    .foregroundStyle(Color(red: 237/255, green: 106/255, blue: 208/255))
                    .font(.system(size: 60))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Text("Prioritize Your Mental Health")
                    .font(.system(.largeTitle, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Text("In the hustle and bustle of life, it's easy to overlook your mental well-being. Foco not only helps you manage your time efficiently but also encourages breaks, mindfulness, and self-care.")
                    .font(.system(.callout, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom, 52)
                
                Spacer()
                NavigationLink(destination: OnboardingSheetPage4()) {
                    Text("Next")
                        .font(.system(.callout, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .foregroundColor(.white)
                        .background(Color(red: 237/255, green: 106/255, blue: 208/255))
                        .mask { RoundedRectangle(cornerRadius: 16, style: .continuous) }
                        .padding(.bottom)
                }
            }
            .padding(.horizontal, 29)
            .padding(.vertical)
            .background {
                LinearGradient(gradient: Gradient(colors: [.clear, Color(red: 237/255, green: 106/255, blue: 208/255).opacity(0.25)]), startPoint: .top, endPoint: .bottom)
            }
            .interactiveDismissDisabled()
        }
        .ignoresSafeArea()
    }
}

struct OnboardingSheetPage4: View {
    @EnvironmentObject var onboardingController: OnboardingController
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    Text("Features:")
                        .font(.system(.largeTitle, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.bottom, 52)
                    VStack(spacing: 28) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(Color(red: 237/255, green: 106/255, blue: 208/255))
                                .font(.system(.title, weight: .regular))
                                .frame(width: 60, height: 50)
                                .clipped()
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Manage Tasks Effectively")
                                    .font(.system(.headline, weight: .semibold))
                                Text("Plan ahead. Define what you want to achieve, helping you stay on track and motivated.")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "rectangle.on.rectangle.angled")
                                .foregroundColor(Color(red: 237/255, green: 106/255, blue: 208/255))
                                .font(.system(.title, weight: .regular))
                                .frame(width: 60, height: 50)
                                .clipped()
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Master Your Knowledge")
                                    .font(.system(.headline, weight: .semibold))
                                Text("Reinforce your learning with flashcards, making it easier to remember and understand complex concepts.")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "timer")
                                .foregroundColor(Color(red: 237/255, green: 106/255, blue: 208/255))
                                .font(.system(.title, weight: .regular))
                                .frame(width: 60, height: 50)
                                .clipped()
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Maximize Focus with Proven Techniques")
                                    .font(.system(.headline, weight: .semibold))
                                Text("Use proven techniques for concentrated work and rejuvenating breaks.")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "wind")
                                .foregroundColor(Color(red: 237/255, green: 106/255, blue: 208/255))
                                .font(.system(.title, weight: .regular))
                                .frame(width: 60, height: 50)
                                .clipped()
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Feeling Overwhelmed?")
                                    .font(.system(.headline, weight: .semibold))
                                Text("Take a breath. Use the breathing feature to find focus and calm amidst chaos.")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "quote.opening")
                                .foregroundColor(Color(red: 237/255, green: 106/255, blue: 208/255))
                                .font(.system(.title, weight: .regular))
                                .frame(width: 60, height: 50)
                                .clipped()
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Need Inspiration?")
                                    .font(.system(.headline, weight: .semibold))
                                Text("Discover motivation and wisdom from famous quotes, inspiring you to keep going.")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
                Button {
                    onboardingController.setShowOnboarding(false)
                } label: {
                    Text("Get Started")
                        .font(.system(.callout, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .foregroundColor(.white)
                        .background(Color(red: 237/255, green: 106/255, blue: 208/255))
                        .mask { RoundedRectangle(cornerRadius: 16, style: .continuous) }
                        .padding(.bottom)
                }
            }
            .padding(.horizontal, 29)
            .padding(.vertical)
            .background {
                LinearGradient(gradient: Gradient(colors: [.clear, Color(red: 237/255, green: 106/255, blue: 208/255).opacity(0.25)]), startPoint: .top, endPoint: .bottom)
            }
        }
        .ignoresSafeArea()
    }
}
