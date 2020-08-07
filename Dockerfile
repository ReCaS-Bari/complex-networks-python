LABEL maintainer="alfonso.monaco@ba.infn.it"

FROM python:3.7

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
           python-keystoneclient python-swiftclient   \
        && rm -rf /var/lib/apt/lists/*

RUN pip install numpy \
    && pip install pandas \
    && pip install matplotlib \
    && pip install networkx \
    && pip install seaborn \
    && pip install roman \
    && pip install scipy \
    && pip install python-igraph 

RUN pip install cython \
    && pip install geos \
    && pip install shapely \
    && pip install pyshp \
    && pip install proj \
    && pip install six

WORKDIR /home

RUN wget http://download.osgeo.org/geos/geos-3.7.3.tar.bz2 \
    && tar -xf geos-3.7.3.tar.bz2 \
    && cd geos-3.7.3 \
    && ./configure \
    && make \
    && make install

WORKDIR /home

RUN wget https://download.osgeo.org/proj/proj-6.3.2.tar.gz \
    && tar -xzf proj-6.3.2.tar.gz \
    && cd proj-6.3.2 \
    && apt-get update \
    && apt-get install sqlite3 \
    && ./configure \
    && make \
    && make install

RUN pip install cartopy
RUN apt-get -y install binutils libproj-dev gdal-bin \
    && ldconfig
RUN pip install adjustText \
    && pip install xlrd \
    && pip install openpyxl \
    && pip uninstall -y shapely \
    && pip install shapely --no-binary shapely

WORKDIR /home

RUN rm -r geos-3.7.3* \
    && rm -r proj-6.3.2*
