FROM ckan/ckan

MAINTAINER Linus Kohl

RUN apt-get -q -y update \
    && apt-get -q -y install \
        libsasl2-dev \
        libldap-dev \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "source $CKAN_VENV/bin/activate && cd $CKAN_VENV/src && \
    pip install -e git+https://github.com/ckan/ckanext-harvest.git#egg=ckanext-harvest && \
    pip install -r ckanext-harvest/pip-requirements.txt && \
    pip install -e git+https://github.com/TheCabbageBaggage/ckanext-doi#egg=ckanext-doi && \
    pip install -r ckanext-doi/requirements.txt && \
    pip install -e git+https://github.com/ckan/ckanext-dcat.git#egg=ckanext-dcat && \
    pip install -r ckanext-dcat/requirements.txt && \
    pip install -e git+https://github.com/sedici/ckanext-oaipmh_repository.git#egg=ckanext-oaipmh_repository && \
    pip install -e git+https://github.com/sedici/ckanext-package_converter.git#egg=ckanext-package_converter && \
    pip install -r ckanext-package-converter/requirements.txt && \
    pip install -e git+https://github.com/ckan/ckanext-scheming.git#egg=ckanext-scheming && \
    pip install -r ckanext-scheming/requirements.txt && \
    pip install ckanext-pdfview"
