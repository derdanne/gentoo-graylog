EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="Daemon that forwards system logs to ElasticSearch databases"
HOMEPAGE="https://www.graylog.org/"
MY_P=graylog-${PV/_/}
SRC_URI="https://packages.graylog2.org/releases/graylog/${MY_P}.tgz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jre
		dev-db/mongodb"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}

src_install() {
	keepdir /etc/graylog
	insinto /etc/graylog
	newins graylog.conf.example graylog-server.conf || die "installing conf failed"
	fperms 644 /etc/graylog/graylog-server.conf || die "fperms failed"

	insinto /opt/graylog-server
	doins -r ./*

	newinitd "${FILESDIR}/graylog.initd" graylog-server || die "newinitd failed"
	newconfd "${FILESDIR}/graylog.confd" graylog-server || die "newconfd failed"

	fperms 0775 /opt/${PN}-server/bin/graylogctl
}

pkg_postinst() {
	ewarn "Visit graylog.org"
}
