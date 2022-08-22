# NiPreps lightweight image of FreeSurfer + infant module
#
# MIT License
#
# Copyright (c) 2022 The NiPreps Developers
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM alpine:3.16

# Update
RUN apk update && \
    apk upgrade && \
    apk add --update curl && \
    apk add --no-cache tar gzip && \
    rm -rf /var/cache/apk/*

# Installing freesurfer
COPY minimized.txt /usr/local/etc/freesurfer-includes.txt
WORKDIR /opt
RUN curl -SL https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/infant/freesurfer-linux-centos7_x86_64-infant-dev-4a14499.tar.gz -o freesurfer.tar.gz \
    && tar -xzvf freesurfer.tar.gz -h --hard-dereference -T /usr/local/etc/freesurfer-includes.txt \
    && rm freesurfer.tar.gz
# Build-stamp hack for wonky infant-dev version
RUN echo "freesurfer-linux-centos7_x86_64-7.1.1-dev-4a14499-20210109-4a14499" > /opt/freesurfer/build-stamp.txt

