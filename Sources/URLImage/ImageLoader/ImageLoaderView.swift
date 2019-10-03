//
//  ImageLoaderView.swift
//  
//
//  Created by Dmytro Anokhin on 20/09/2019.
//

import SwiftUI


@available(iOS 13.0, tvOS 13.0, *)
struct ImageLoaderView<Placeholder> : View where Placeholder : View {

    let url: URL

    let placeholder: (_ partialImage: PartialImage) -> Placeholder

    let delay: TimeInterval

    let incremental: Bool

    init(_ url: URL, delay: TimeInterval, incremental: Bool, imageLoaderService: ImageLoaderService, placeholder: @escaping (_ partialImage: PartialImage) -> Placeholder) {
        self.url = url
        self.placeholder = placeholder
        self.delay = delay
        self.incremental = incremental
        self.imageLoaderService = imageLoaderService
        self.onLoad = nil
        self.onPartial = nil
    }

    var body: some View {
        let partialImage = PartialImage()

        let observer = ImageLoaderObserver(
            progress: { progress in
                partialImage.progress = progress
            },
            partial: { imageProxy in
                self.onPartial?(imageProxy)
            },
            completion: { imageProxy in
                self.onLoad?(imageProxy)
            })

        return placeholder(partialImage)
            .onAppear {
                self.imageLoaderService.subscribe(forURL: self.url, incremental: self.incremental, observer)
                self.imageLoaderService.load(url: self.url, delay: self.delay)
            }
            .onDisappear {
                self.imageLoaderService.unsubscribe(observer, fromURL: self.url)
            }
    }

    func onLoad(perform action: ((_ imageProxy: ImageProxy) -> Void)? = nil) -> ImageLoaderView<Placeholder> {
        return ImageLoaderView(url, delay: delay, incremental: incremental, imageLoaderService: imageLoaderService, placeholder: placeholder, onLoad: action, onPartial: onPartial)
    }

    func onPartial(perform action: ((_ imageProxy: ImageProxy) -> Void)? = nil) -> ImageLoaderView<Placeholder> {
        return ImageLoaderView(url, delay: delay, incremental: incremental, imageLoaderService: imageLoaderService, placeholder: placeholder, onLoad: onLoad, onPartial: action)
    }

    private init(_ url: URL, delay: TimeInterval, incremental: Bool, imageLoaderService: ImageLoaderService, placeholder: @escaping (_ partialImage: PartialImage) -> Placeholder, onLoad: ((_ imageProxy: ImageProxy) -> Void)?, onPartial: ((_ imageProxy: ImageProxy) -> Void)?) {
        self.url = url
        self.placeholder = placeholder
        self.delay = delay
        self.incremental = incremental
        self.imageLoaderService = imageLoaderService
        self.onLoad = onLoad
        self.onPartial = onPartial
    }

    private let imageLoaderService: ImageLoaderService

    private let onLoad: ((_ imageProxy: ImageProxy) -> Void)?

    private let onPartial: ((_ imageProxy: ImageProxy) -> Void)?
}
