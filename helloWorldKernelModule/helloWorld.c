#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

static int __init hello_init(void)
{
	printk(KERN_ALERT "Module has been loaded \n");
	printk(KERN_ALERT "HELLO !! \n");
	return 0;
}


static void __exit hello_exit(void){
	printk(KERN_ALERT "Module has been unloaded \n");
	printk(KERN_ALERT "BYE SHITTY WORLD!! \n");
}

module_init(hello_init);
module_exit(hello_exit);
