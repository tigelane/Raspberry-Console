FROM node:6.11-alpine

MAINTAINER Tige Phillips <tige@tigelane.com>

####################
# PYTHON and TOOLS #
####################
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN apk add --no-cache bash
RUN pip3 install --upgrade pip
RUN pip3 install requests
RUN pip3 install flask requests


#################
RUN mkdir /opt/petal
ADD petal_server.py /opt/petal/

WORKDIR /opt/petal

# By default when this container runs, simply start the application
CMD /opt/petal/petal_server.py -D FOREGROUND
