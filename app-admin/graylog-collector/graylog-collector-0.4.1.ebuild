EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="Daemon that forwards system logs to ElasticSearch databases"
HOMEPAGE="https://www.graylog.org/"
MY_PN=${PN}
MY_P=${PN}-${PV/_/}
SRC_URI="https://packages.graylog2.org/releases/${PN}/${MY_P}.tgz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jre"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}

src_install() {
	keepdir /etc/graylog
	insinto /etc/graylog
	newins config/collector.conf.example graylog-collector.conf || die "installing conf failed"
	fperms 644 /etc/graylog/graylog-collector.conf || die "fperms failed"

	insinto /opt/graylog-collector
	doins -r ./*

	newinitd "${FILESDIR}/graylog-collector.initd" graylog-collector || die "newinitd failed"
	newconfd "${FILESDIR}/graylog-collector.confd" graylog-collector || die "newconfd failed"

	fperms 0775 /opt/${PN}/bin/{graylog-collector,graylog-collector-script-config.sh}
}

pkg_postinst() {
	ewarn "Visit graylog.org"
}
