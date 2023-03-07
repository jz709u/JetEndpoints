//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/03/06.
//

import Foundation
import Quick
import Nimble
import JetEndpoints

class JEServerPathsTests: QuickSpec {
    
    enum TestPaths: String, JEServerPaths {
        case hello
        case one_two_three
        case light__brightness_2
        case light__brightness_2__color_green
        case light__
    }
    override func spec() {
        describe("testing single path 'hello'") {
            it("should equal hello") {
                expect(try TestPaths.hello.asPath())
                    .to(equal("hello"))
            }
        }
        
        describe("testing nested paths") {
            it("should equal one/two/three") {
                expect(try TestPaths.one_two_three.asPath())
                    .to(equal("one/two/three"))
            }
        }
        
        describe("testing query params") {
            it("should have one query param brightness equal to 2") {
                expect(try TestPaths.light__brightness_2.asPath())
                    .to(equal("light?brightness=2"))
            }
            
            it("should have two query params brightness equal to 2 and color equal to green") {
                expect(try TestPaths.light__brightness_2__color_green.asPath())
                    .to(equal("light?brightness=2&color=green"))
            }
        }
        
        describe("testing ending with __") {
            it("should be just the path light") {
                expect(try TestPaths.light__.asPath())
                    .to(equal("light"))
            }
        }
    }
}
