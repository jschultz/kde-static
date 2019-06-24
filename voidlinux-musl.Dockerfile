FROM voidlinux/voidlinux-musl
MAINTAINER Jonathan Schultz <jonathan@schultz.la>

# Save proxy for use after build - watch for secrets!
ENV http_proxy  $http_proxy
ENV https_proxy $https_proxy
ENV ftp_proxy   $ftp_proxy

# Copy certificate
ARG certificate
COPY $certificate /usr/share/ca-certificates
RUN chmod go+r /usr/share/ca-certificates/$certificate
RUN echo $certificate >> /etc/ca-certificates.conf && update-ca-certificates

# Change mirror
ARG mirror
ENV mirror ${mirror:-alpha.de.repo.voidlinux.org}
RUN cp /usr/share/xbps.d/*repository* /etc/xbps.d && sed -i -e "s|alpha.de.repo.voidlinux.org|$mirror|g" /etc/xbps.d/*repository*

# Need to do sync/update in two stages because xbps needs to be update before remaining packages
RUN xbps-install --sync --yes xbps
RUN xbps-install --update --yes

# Get voidlinux ready for building
RUN xbps-install --yes xtools
RUN git clone --depth 1 https://github.com/jschultz/void-packages && cd void-packages && ./xbps-src binary-bootstrap
RUN cd void-packages && sed -i -e "s|alpha.de.repo.voidlinux.org|$mirror|g" etc/* && \
	./xbps-src binary-bootstrap
