//
//  listaReporteDependencia.h
//  Obras-Programas
//
//  Created by Abdiel on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "Dependencia.h"

@interface ListaReporteDependencia : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *numeroObras;
@property (nonatomic, strong) NSNumber *totalInvertido;
@property (nonatomic, strong) Dependencia *dependencia;
@end
