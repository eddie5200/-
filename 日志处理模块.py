import logging
import logging.config

##默认的处理器StreamHandler的log配置，将日志输出到控制台
def log_StreamHandler():
    '''
    stream代表类文件对象，默认为空即支持write()或者flush()的对象
    stream为空代表将日志输出到控制台，包括标准错误日志，标准日志,
    '''

    ##创建记录器logger
    logger=logging.getLogger()
    logger.setLevel(logging.DEBUG)

   
    ##创建处理器StreamHandler
    handler=logging.StreamHandler()
    handler.setLevel(logging.WARNING)

    ###创建格式化器
    fmt='%(asctime)s [%(process)d] [%(threadName)s] [%(name)s] [%(levelname)s] [%(filename)s][%(funcName)s] [line:%(lineno)d] %(message)s'
    datefmt='%Y-%m-%d %H:%M:%S'
    formatter=logging.Formatter(fmt,datefmt)

    ##将格式化器和处理器加入到记录器
    logger.addHandler(handler)
    handler.setFormatter(formatter)

    ###时输出日志
    logger.debug('log debug')
    logger.info('log info')
    logger.warning('log warning')
    logger.error('log error')
    logger.critical('log critical')
log_StreamHandler()


###FileHandler处理器的log配置，将日志写入磁盘
def log_FileHandler(filename):
    '''
    filename:日志文件名
    '''

    ##创建记录器
    logger=logging.getLogger()
    logger.setLevel(logging.DEBUG)

    ##创建处理器
    handler=logging.FileHandler(filename,mode='a',encoding='utf-8')
    handler.setLevel(logging.DEBUG)

    ##创建格式化器
    fmt='%(asctime)s [%(process)d] [%(threadName)s] [%(name)s] [%(levelname)s] [%(filename)s][%(funcName)s] [line:%(lineno)d] %(message)s'
    datefmt='%Y-%m-%d %H:%M:%S'
    formatter=logging.Formatter(fmt,datefmt)

    ##将处理器加入到记录器，将格式化器加入到处理器
    logger.addHandler(handler)
    handler.setFormatter(formatter)

    ##输出日志
    logger.debug('log debug')
    logger.info('log info')
    logger.warning('log warning')
    logger.error('log error')
    logger.critical('log critical')
log_FileHandler(r'C:\Users\Wecar\Desktop\log.txt')


#RotatingFileHandler处理器的log配置,按文件大小循环日志文件
#参数maxBytes和backupCount允许日志文件在达到maxBytes时rollover.当文件大小达到或者超过maxBytes时，就会新创建一个日志文件。
def log_RotatingFileHandler(filename,size,num,model,message):
    '''
    filename:日志文件名
    size:日志文件大小，单位为M
    num:创建文件的个数
    model:输出什么类型的日志，debug,info,error,warning，critical
    message:输出信息
    '''

    ##创建记录器
    logger=logging.getLogger()
    logger.setLevel(logging.DEBUG)

    ##创建处理器
    handler=logging.handlers.RotatingFileHandler(filename,mode='a',maxBytes=1048576*size,backupCount=num,encoding='utf8')
    handler.setLevel(logging.DEBUG)

    ##创建格式化器
    fmt='%(asctime)s [%(process)d] [%(threadName)s] [%(name)s] [%(levelname)s] [%(filename)s][%(funcName)s] [line:%(lineno)d] %(message)s'
    datefmt='%Y-%m-%d %H:%M:%S'
    formatter=logging.Formatter(fmt,datefmt)

    ##将处理器加入到记录器，将格式化器加入到处理器
    logger.addHandler(handler)
    handler.setFormatter(formatter)

    ##输出日志
    if model=='debug':
        logger.debug(message)
    elif model=='info':
        logger.info(message)
    elif model=='warning':
        logger.info(message)
    elif model=='error':
        logger.error(message)
    else:
        logger.critical(message)   
log_RotatingFileHandler(r'C:\Users\Wecar\Desktop\log1.txt',2,1,'debug','log debug')


##TimedRotatingFileHandler处理器的log配置，定时生成新日志文件。
def log_TimedRotatingFileHandler(filename,n,m,num,model,message):
    '''
    n决定了时间间隔的类型
        'S'         |  秒
        'M'         |  分
        'H'         |  时
        'D'         |  天
        'W0'-'W6'   |  周一至周日
        'midnight'  |  每天的凌晨
    m决定了多少的时间间隔。如when='D'，interval=2，就是指两天的时间间隔，
    num决定了能留几个日志文件。超过数量就会丢弃掉老的日志文件。

    '''
    ##创建记录器
    logger=logging.getLogger()
    logger.setLevel(logging.DEBUG)

    ##创建处理器
    handler=logging.handlers.TimedRotatingFileHandler(filename,when=n,interval=m,backupCount=num,encoding='utf-8',)
    handler.setLevel(logging.DEBUG)

    ##创建格式化器
    fmt='%(asctime)s [%(process)d] [%(threadName)s] [%(name)s] [%(levelname)s] [%(filename)s][%(funcName)s] [line:%(lineno)d] %(message)s'
    datefmt='%Y-%m-%d %H:%M:%S'
    formatter=logging.Formatter(fmt,datefmt)

    ###将处理器加入到记录器，将格式化器加入到处理器
    logger.addHandler(handler)
    handler.setFormatter(formatter)

    ##输出日志
    if model=='debug':
        logger.debug(message)
    elif model=='info':
        logger.info(message)
    elif model=='warning':
        logger.info(message)
    elif model=='error':
        logger.error(message)
    else:
        logger.critical(message)   
log_TimedRotatingFileHandler(r'C:\Users\Wecar\Desktop\log1.txt','D',1,2,'debug','log debug uuu')