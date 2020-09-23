//
//  URLSessionDelegate.swift
//  
//
//  Created by Dmytro Anokhin on 13/07/2020.
//

import Foundation


final class URLSessionDelegate : NSObject {

    // URLSessionTaskDelegate

    /// func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
    typealias TaskDidCompleteWithError = (_ task: URLSessionTask, _ error: Error?) -> Void

    private var taskDidCompleteWithError: TaskDidCompleteWithError?

    @discardableResult
    func onTaskDidCompleteWithError(_ handler: @escaping TaskDidCompleteWithError) -> Self {
        taskDidCompleteWithError = handler
        return self
    }

    // URLSessionDataDelegate

    /// func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void)
    typealias DataTaskDidReceiveResponse = (_ task: URLSessionDataTask, _ response: URLResponse, _ completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) -> Void

    private var dataTaskDidReceiveResponse: DataTaskDidReceiveResponse?

    @discardableResult
    func onDataTaskDidReceiveResponse(_ handler: @escaping DataTaskDidReceiveResponse) -> Self {
        dataTaskDidReceiveResponse = handler
        return self
    }

    /// func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
    typealias DataTaskDidReceiveData = (_ task: URLSessionDataTask, _ data: Data) -> Void

    private var dataTaskDidReceiveData: DataTaskDidReceiveData?

    @discardableResult
    func onDataTaskDidReceiveData(_ handler: @escaping DataTaskDidReceiveData) -> Self {
        dataTaskDidReceiveData = handler
        return self
    }
}


extension URLSessionDelegate : Foundation.URLSessionDelegate {

    //optional func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?)
    //
    //
    //optional func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
}


extension URLSessionDelegate : URLSessionTaskDelegate {


//    @available(OSX 10.13, *)
//    optional func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest request: URLRequest, completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void)
//
//
//    @available(OSX 10.13, *)
//    optional func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask)
//
//
//    optional func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void)
//
//
//    optional func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
//
//
//    optional func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void)
//
//
//    optional func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64)
//
//
//    @available(OSX 10.12, *)
//    optional func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics)


    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(#function)
        taskDidCompleteWithError?(task, error)
    }
}


extension URLSessionDelegate : URLSessionDataDelegate {

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print(#function)
        dataTaskDidReceiveResponse?(dataTask, response, completionHandler)
    }

//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask)

//    @available(OSX 10.11, *)
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask)

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function)
        dataTaskDidReceiveData?(dataTask, data)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        print(#function)
        completionHandler(proposedResponse)
    }
}


extension URLSessionDelegate : URLSessionDownloadDelegate {

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(#function)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print(#function)
        // URLCache.shared.storeCachedResponse(CachedURLResponse(response: res!, data: data), for: req)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print(#function)
    }
}