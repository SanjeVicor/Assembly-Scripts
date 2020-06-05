#include <linux/init.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/slab.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/module.h>
#include <linux/kernel.h>

#define DEV_NAME "team_Nine_device"
#define MEM_SIZE 256

static ssize_t read_Dev(struct file *, char *, size_t, loff_t *);
static ssize_t write_Dev(struct file *, const char __user*, size_t,loff_t *);
static int open_Dev(struct inode *, struct file *);
static int release_Dev(struct inode *, struct file *);

static const struct file_operations fops = {//file operations
    .owner = THIS_MODULE,
    .open = open_Dev,
    .release = release_Dev,
    .read = read_Dev,
    .write = write_Dev,
};

static char *memory = NULL; //main buffer 
static char *fileName = NULL;
static char *finalName = NULL;
static dev_t firstDev = NULL;
static unsigned int minorCount = 2; 
static int major = 9, minor = 0;
static struct cdev *charDev = NULL;
static int counter = 0; // times that device has been opened

static int open_Dev(struct inode *inode, struct file *file)
{
    counter += 1 ;
    printk(KERN_INFO "Dispositivo abierto \n");
    printk(KERN_INFO "Major number = %u \n",imajor(inode));
    printk(KERN_INFO "Minor number = %u \n",iminor(inode));
    printk(KERN_INFO "Se ha abierto un total de %u veces \n",counter);

    return 0;
}

static int release_Dev(struct inode *inode, struct file *file){
    printk(KERN_INFO "Dispositivo cerrado \n");
    return 0;
}

static ssize_t read_Dev(struct file *file, char __user *buf, size_t message_len, loff_t *pos){
    ssize_t ret = -1;
    if(message_len>MEM_SIZE)
    {
        printk(KERN_WARNING "ERROR EN LECTURA, se sobre pasa el tamaño del buffer");
        return ret;
    }

    finalName = d_path(&file->f_path, fileName, MEM_SIZE);
    printk(KERN_INFO "Dispositivo : %s \n", finalName);
    printk(KERN_INFO "Contenido : %s \n", memory);

    ret = (ssize_t)copy_to_user(buf, memory, message_len);
    
    printk(KERN_INFO "Numero de bytes del contenido : %d \n", (int)(message_len-ret));
    
    return message_len-ret;
}



static ssize_t write_Dev(struct file *file, const char __user *buf, size_t message_len,loff_t *pos){
    ssize_t ret = -1;
    if(message_len>MEM_SIZE)
    {
        printk(KERN_WARNING "ERROR EN ESCRITURA, se sobre pasa el tamaño del buffer");
        return ret;
    }
    finalName = d_path(&file->f_path, fileName, MEM_SIZE);
    printk(KERN_INFO "Escribiendo en dispositivo : %s \n", finalName);
    ret = (ssize_t)copy_from_user(memory,buf, message_len);
    printk(KERN_INFO "Numero de bytes escritos : %d \n", (int)(message_len-ret));

    return message_len-ret;
}

static int __init devInit(void)
{
    int retVal = -1;
    memory = kmalloc(MEM_SIZE, GFP_KERNEL);
    fileName = kmalloc(MEM_SIZE, GFP_KERNEL);
    firstDev = MKDEV(major,minor);
    retVal = register_chrdev_region(firstDev, minorCount, DEV_NAME);

    if(0 != retVal)
    {
        pr_emerg("Fallo al intentar registrar MAJOR");
        return -1;
    }
    charDev = cdev_alloc();
    if(NULL == charDev)
    {
        pr_emerg("Error al intentar alojar el dispositivo");
        return -1;
    }
    cdev_init(charDev, &fops);
    retVal = cdev_add(charDev, firstDev, minorCount);
    if(0 > retVal)
    {
        pr_emerg("Error al intentar cargar");
        return -1;
    }
    pr_info("Se cargo el modulo correctamente \n");
    pr_info("Major number = %d \n",major);
    pr_info("Minor number = %d \n",minor);
    return 0;
}

static void __exit devExit(void)
{
    cdev_del(charDev);
    unregister_chrdev_region(firstDev, minorCount);
    kfree(finalName);
    kfree(fileName);
    kfree(memory);
    pr_emerg("Se a desalojado el dispositivo del computador");
}

module_init(devInit);
module_exit(devExit);