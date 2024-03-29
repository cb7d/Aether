//
//  ATMMemory.m
//  Aether
//
//  Created by Felix on 2019/10/9.
//

#import "ATMMemory.h"
#import <mach/mach.h>

@implementation ATMMemory

- (NSString *)titleForPlugin {
    return @"Memory";
}

- (NSString *)valueForPlugin {
    return [NSString stringWithFormat:@"%.2f M", [self getUsedMemory]];
}

- (float)getUsedMemory {
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (kernReturn != KERN_SUCCESS) { return NSNotFound; }
    memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
    return memoryUsageInByte/1024.0/1024.0;
}

@end
