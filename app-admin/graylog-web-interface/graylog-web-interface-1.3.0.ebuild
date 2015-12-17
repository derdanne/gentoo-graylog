EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="Daemon that forwards system logs to ElasticSearch databases"
HOMEPAGE="https://www.graylog.org/"
MY_PN=${PN}
MY_P=${PN}-${PV/_/}
SRC_URI="https://packages.graylog2.org/releases/graylog2-web-interface/${MY_P}.tgz"
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
	newins conf/graylog-web-interface.conf graylog-web-interface.conf || die "installing conf failed"
	fperms 644 /etc/graylog/graylog-web-interface.conf || die "fperms failed"

	insinto /opt/graylog-web-interface
	doins -r ./bin
	doins -r ./lib
	doins ./README.md
	insinto /opt/graylog-web-interface/conf
	doins ./conf/application.conf
	doins ./conf/play.plugins
	dosym /etc/graylog/graylog-web-interface.conf /opt/graylog-web-interface/conf 

	newinitd "${FILESDIR}/graylog-web.initd" graylog-web || die "newinitd failed"
	newconfd "${FILESDIR}/graylog-web.confd" graylog-web || die "newconfd failed"

	fperms 0775 /opt/${PN}/bin/graylog-web-interface
}

pkg_postinst() {
	ewarn "Visit graylog.org"
}
