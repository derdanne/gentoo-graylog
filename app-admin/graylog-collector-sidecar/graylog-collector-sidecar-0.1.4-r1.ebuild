EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="Daemon that forwards system logs to ElasticSearch databases"
HOMEPAGE="https://www.graylog.org/"
MY_PN=${PN}
MY_P=${PN}-${PV/_/}
SRC_URI="https://github.com/Graylog2/collector-sidecar/releases/download/0.1.4/collector-sidecar_0.1.4-1_amd64.deb"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jre"

RDEPEND="!app-admin/graylog-collector
         !app-admin/filebeat
         ${DEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
    unpack ./data.tar.gz
}

src_install() {
	keepdir /etc/graylog
	insinto /etc/graylog
    doins -r ./etc/graylog/*   
	fperms 755 /etc/graylog/collector-sidecar || die "fperms failed"
    fperms 644 /etc/graylog/collector-sidecar/collector_sidecar.yml
    fperms 755 /etc/graylog/collector-sidecar/generated

    dodir /var/log/graylog
    dodir /var/log/graylog/collector-sidecar
    
    dodir /opt/graylog-collector-sidecar
    dodir /opt/graylog-collector-sidecar/bin
	insinto /opt/graylog-collector-sidecar/bin
    doins ./usr/bin/graylog-collector-sidecar 
    doins ./usr/bin/filebeat 

	newinitd "${FILESDIR}/graylog-collector-sidecar.initd" graylog-collector-sidecar || die "newinitd failed"
	newconfd "${FILESDIR}/graylog-collector-sidecar.confd" graylog-collector-sidecar || die "newconfd failed"

	fperms 0775 /opt/${PN}/bin/graylog-collector-sidecar
    fperms 0775 /opt/${PN}/bin/filebeat

    dosym /opt/${PN}/bin/filebeat /usr/bin/filebeat
}

pkg_postinst() {
	ewarn "Visit graylog.org"
}
