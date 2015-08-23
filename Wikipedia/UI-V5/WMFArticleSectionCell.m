//  Created by Monte Hurd on 7/2/15.
//  Copyright (c) 2015 Wikimedia Foundation. Provided under MIT-style license; please copy and modify!

#import "WMFArticleSectionCell.h"
#import "UITableViewCell+WMFEdgeToEdgeSeparator.h"

@interface WMFArticleSectionCell ()

@property (weak, nonatomic) IBOutlet UIButton* disclosureIndicatorButton;

@end

@implementation WMFArticleSectionCell

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    CGFloat prevWidth = self.titleLabel.preferredMaxLayoutWidth;
//    CGFloat newWidth = self.titleLabel.frame.size.width;
//    if (prevWidth != newWidth) {
//        self.titleLabel.preferredMaxLayoutWidth = newWidth;
//        [super layoutSubviews];
//    }
//}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = @"";
}

@end
