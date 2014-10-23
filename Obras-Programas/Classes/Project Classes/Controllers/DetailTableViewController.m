//
//  DetailTableViewController.m
//  Obras-Programas
//
//  Created by Abdiel on 10/11/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Obra.h"
#import "Programa.h"
#import "Consulta.h"
#import "FichaTecnicaViewController.h"

@interface DetailTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property  CGSize size;
@property MenuOptions option;
@property CGFloat labelSize;

@end

@implementation DetailTableViewController


-(id)initWithDataSource:(NSArray *)dataSource menuOption:(MenuOptions)option{
    
    
    if ([super initWithStyle:UITableViewStylePlain] !=nil) {
        
        _option = option;
        self.dataSource     = dataSource;

        /* Initialize instance variables */
        self.navigationController.navigationBar.hidden = NO;
        self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger totalRowsHeight = 0;
        self.tableView.backgroundColor = [UIColor clearColor];
        //Calcula el ancho que debe tener la vista buscando que ancho de cada string se espera que sea
        
        CGFloat largestLabelWidth = 0;
        _labelSize = _option == o_Consultas ? 17.0 : 14.5;
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:_labelSize];
        
        if (_option == o_Consultas) {
            NSInteger rowsCount = [self.dataSource count];
            totalRowsHeight  = (rowsCount * 45) + 45;
            
            for (Consulta *consulta in self.dataSource) {
                
                NSString *title = consulta.nombreConsulta;
                
                CGSize labelSize = [title sizeWithAttributes:  @{NSFontAttributeName:font}];
                if (labelSize.width > largestLabelWidth) {
                    largestLabelWidth = labelSize.width;
                }
                
                largestLabelWidth = largestLabelWidth + 20;
            }
        }else if (_option == o_Favoritos){
            
            for (NSArray *obrasProgramas in _dataSource) {
                NSInteger rowsCount = [obrasProgramas count];
                totalRowsHeight = totalRowsHeight + (rowsCount * 45);
            }
            totalRowsHeight = totalRowsHeight + 100;
            NSArray *obras = _dataSource[0];
            for (Obra *obra in obras) {
                
                NSString *title = obra.denominacion;
                CGSize labelSize = [title sizeWithAttributes: @{NSFontAttributeName: font}];
                
                if (labelSize.width > largestLabelWidth) {
                    largestLabelWidth = largestLabelWidth + labelSize.width;
                }
            }

            NSArray *programas = _dataSource[1];
            for (Programa *programa in programas) {
                NSString *title = programa.nombrePrograma;
                CGSize labelSize = [title sizeWithAttributes: @{NSFontAttributeName:font}];
                if (labelSize.width > largestLabelWidth) {
                    largestLabelWidth = largestLabelWidth + labelSize.width;
                }
            }
        }
        //Agrega un pequeño padding al ancho
        CGFloat popoverWidth = largestLabelWidth + 90;
        _size = CGSizeMake(popoverWidth, totalRowsHeight);
        //Establece la propiedad para decirle al contenedor del popover que tan grande sera su vista
        self.preferredContentSize = _size;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (_option == o_Consultas) {
        return 1;
    }else{
        return _dataSource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (_option == o_Consultas) {
        return _dataSource.count;
    }else{
        if (section == 0) {
            return [_dataSource[0] count];
            
        }else if (section == 1){
            return [_dataSource[1] count];
        }
        return 0;

    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (_option == o_Consultas) {
        return @"";
    }else{
        if (section==0) {
            return @"Obras";
        }else{
            return @"Programas";
        }
    }
}
   

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:_labelSize];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (_option == o_Consultas) {
        
        Consulta *consulta = _dataSource[indexPath.row];
        
        cell.textLabel.text         = [NSString stringWithFormat:@"%ld.- %@ ",(long)indexPath.row+1, consulta.nombreConsulta];
        cell.detailTextLabel.text   = [NSString stringWithFormat:@"      %@", [NSDate date]];
        return cell;

    }else{
        NSArray *registros = _dataSource[indexPath.section];

        if (indexPath.section == 0) {
            
            Obra *obra = registros[indexPath.row];
            
            cell.textLabel.text         = [NSString stringWithFormat:@"%ld.- %@ ",(long)indexPath.row+1, obra.denominacion];
            cell.detailTextLabel.text   = [NSString stringWithFormat:@"      %@", obra.idObra];
            
        }else if (indexPath.section == 1){

            Programa *programa = registros[indexPath.row];
            cell.textLabel.text         = [NSString stringWithFormat:@"%ld.- %@ ",(long)indexPath.row+1, programa.nombrePrograma];
            cell.detailTextLabel.text   = [NSString stringWithFormat:@"      %@", programa.idPrograma];
        }
        return cell;

    }
}

#pragma mark - UITableView  Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [self dismissViewControllerAnimated:YES completion:nil];

    if (_option == o_Consultas) {
        
    }else if (_option == o_Favoritos){
        NSArray *registros = _dataSource[indexPath.section];

        if (indexPath.section == 0) {
            Obra *obra = registros[indexPath.row];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showFichaTecnica" object:obra];

        }else if (indexPath.section == 1){
            Programa *programa = registros[indexPath.row];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showFichaTecnica" object:programa];
        }

    }
}

@end
