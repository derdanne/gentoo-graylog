EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="Plugin for reporting internal Graylog metrics to other systems."
HOMEPAGE="https://github.com/graylog-labs/graylog-plugin-metrics-reporter/tree/master/metrics-reporter-prometheus"
MY_P=graylog-${PV/_/}
SRC_URI="https://github.com/graylog-labs/graylog-plugin-metrics-reporter/releases/download/${PV}/metrics-reporter-prometheus-${PV}.jar"
LICENSE="Apache License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/graylog"

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
   cp ${DISTDIR}/metrics-reporter-prometheus-${PV}.jar ${WORKDIR}/metrics-reporter-prometheus-${PV}.jar
}

src_install() {
	insinto /opt/graylog-server/plugin/
	doins ${WORKDIR}/metrics-reporter-prometheus-${PV}.jar
}

pkg_postinst() {
	ewarn "Docs located at https://github.com/graylog-labs/graylog-plugin-metrics-reporter/blob/master/metrics-reporter-prometheus/"
}
