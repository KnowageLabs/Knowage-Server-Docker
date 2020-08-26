import multiprocessing

bind = "0.0.0.0:5000"
workers = multiprocessing.cpu_count() * 2 + 1
timeout = 30
keepalive = 2
user = 'knowage'
group = 'knowage'
###tmp_upload_dir = None
pidfile ='/app/knowagepython.pid'

###capture-output = 'true'
loglevel = 'debug'
accesslog = '-'
errorlog = '-'
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'

