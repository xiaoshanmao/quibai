//
//  ViewController.m
//  quibai
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "joke.h"
#import "Hpple/TFHpple.h"

@interface ViewController ()
{
    NSMutableArray *_jokeArray;
    NSUInteger index;
}

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *aratarImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _jokeArray = [NSMutableArray array];
    [self loadjoke];
    [self displayWithJoke:[_jokeArray firstObject]];
    index = 0;
}

- (void)loadjoke
{
    NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.qiushibaike.com/text"]];
    TFHpple *hpple = [TFHpple hppleWithHTMLData:xmlData encoding:@"utf-8"];
    NSArray *eles = [hpple searchWithXPathQuery:@"//div[@class='article block untagged mb15']"];
    for (TFHppleElement *ele in eles) {
        
        NSArray *tempeles = [ele searchWithXPathQuery:@"//div[@class='content']"];
        TFHppleElement *lele = [tempeles firstObject];
        NSString *content =[lele content];
        
        NSArray *tempeles1 = [ele searchWithXPathQuery:@"//h2"];
        TFHppleElement *lele1 = [tempeles1 firstObject];
        NSString *rotes = [lele1 content];
       
        NSArray *tempeles2 = [ele searchWithXPathQuery:@"//i[@class='number']"];
        TFHppleElement *lele2 = [tempeles2 firstObject];
        NSString *nickName = [lele2 content];
        
        NSArray *tempeles3 = [ele searchWithXPathQuery:@"//@src"];
        TFHppleElement *lele3 = [tempeles3 firstObject];
        NSString *arator = [lele3 content];
        
        NSArray *tempeles4 = [ele searchWithXPathQuery:@"//i[@class='number']"];
        TFHppleElement *lele4 = [tempeles4 lastObject];
        NSString *comment = [lele4 content];
        
        joke *jok = [joke new];
        jok.nickName = nickName;
        jok.aratorStr = arator;
        jok.rotes = rotes;
        jok.content = content;
        jok.comment = comment;
        
        [_jokeArray addObject:jok];
    }
}


- (IBAction)preButtonCliked:(id)sender {
    
    if (index ==0) {
        
        index = [_jokeArray count] - 1;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }else{
        
        index--;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }
    
}
- (IBAction)nextButtonCliked:(UIButton *)sender {
    
    if (index == [_jokeArray count] - 1) {
        
        index = 0;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }else{
        
        index++;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }
}


- (void)displayWithJoke:(joke *)jok{

    _nickNameLabel.text = jok.rotes;
    _contentTextView.text = jok.content;
    _rotesLabel.text = [NSString stringWithFormat:@"%@好笑",jok.nickName];
    _commentLabel.text = [NSString stringWithFormat:@"%@评论",jok.comment];
    [_aratarImageView setImage:[UIImage imageNamed:@"1.jpg"]];
    //[_aratarImageView setImageWithURL:[NSURL URLWithString:jok.aratorStr]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
