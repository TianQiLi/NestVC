# NestVC

 pod install 
 
 how to use:
     when you want to use this demo ,you can inherit the Nest_CollectionViewCell class to custom the style of collection
 
 introduction :
    the core framework is collection as a containers that is control the horizontal roll , 
    Nest_CollectionViewCell is the   containers collection's  cell；
    in addition ,Nest_CollectionViewCell include a subCollection to satisfy u custom cell implement
 
DEMO:

create a new ViewController:

NestVC * courseVC = [[NestVC alloc] initWithSwitchItemArray:@[@"录播",@"直播",@"试卷"]  withClassArray:@[NSStringFromClass([Free_CourseVC class])] withIdentifiter:@[[Free_CourseVC  cellIdentifiter]]];
    [self.navigationController pushViewController:courseVC animated:YES];
