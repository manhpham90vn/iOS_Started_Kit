//
//  File.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

protocol Assembler: class, AppAssembler, RepositoriesAssembler,
    LoginAssembler,
    EventAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}

