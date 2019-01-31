FROM voidlinux/voidlinux-musl
MAINTAINER Jonathan Schultz <jonathan@schultz.la>

# Use Australian mirror site
RUN cp /usr/share/xbps.d/*repository* /etc/xbps.d && sed -i -e 's|alpha.de.repo.voidlinux.org|mirror.aarnet.edu.au/pub/voidlinux|g' /etc/xbps.d/*repository*
RUN xbps-install --update --sync --yes

# Set up proxy
COPY myCA.pem /usr/share/ca-certificates
RUN chmod go+r /usr/share/ca-certificates/myCA.pem
RUN echo myCA.pem >> /etc/ca-certificates.conf && update-ca-certificates
ENV ftp_proxy http://172.17.0.1:3128
ENV http_proxy http://172.17.0.1:3128
ENV https_proxy http://172.17.0.1:3128

# Get voidlinux ready for building
RUN xbps-install --yes xtools
RUN git clone --depth 1 https://github.com/jschultz/void-packages && cd void-packages && ./xbps-src binary-bootstrap
RUN cd void-packages && sed -i -e 's|alpha.de.repo.voidlinux.org|mirror.aarnet.edu.au/pub/voidlinux|g' etc/* && \
	./xbps-src binary-bootstrap
