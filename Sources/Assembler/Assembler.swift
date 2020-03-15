//
//  File.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

protocol Assembler: class, AppAssembler, RepositoriesAssembler,
    HomeAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}

