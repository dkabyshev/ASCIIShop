//
//  RxDependencies.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// Utility class to use along with Rx, mainly as shared execution queues
final class RxDependencies {
    static let shared = RxDependencies() // Singleton
    
    let backgroundWorkScheduler: ImmediateSchedulerType
    let mainScheduler: SerialDispatchQueueScheduler
    
    private init() {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        mainScheduler = MainScheduler.instance
    }
    
}

extension ObservableType {
    
    /**
     Pauses the elements of the source observable sequence based on the latest element from the second observable sequence.
     Elements are ignored unless the second sequence has most recently emitted `true`.
     - seealso: [pausable operator on reactivex.io](http://reactivex.io/documentation/operators/backpressure.html)
     - parameter pauser: The observable sequence used to pause the source observable sequence.
     - returns: The observable sequence which is paused based upon the pauser observable sequence.
     */
    public func pausable<P: ObservableType>(pauser: P) -> Observable<E> where P.E == Bool {
        return withLatestFrom(pauser) { element, paused in
            (element, paused)
            }.filter { element, paused in
                paused
            }.map { element, paused in
                element
        }
    }
    
}

// Two way binding operator between control property and variable, that's all it takes

infix operator <-> : DefaultPrecedence

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    if T.self == String.self {
        #if DEBUG
            fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx.text` property directly to variable.\n" +
                "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
                "REMEDY: Just use `textField <-> variable` instead of `textField.rx.text <-> variable`.\n" +
                "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
        #endif
    }
    
    let bindToUIDisposable = variable.asObservable()
        .bindTo(property)
    let bindToVariable = property
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}
