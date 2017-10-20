EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="QuickValuesPlus Widget Plugin for Graylog2"
HOMEPAGE="https://github.com/billmurrin/graylog-plugin-quickvaluesplus-widget"
MY_P=graylog-${PV/_/}
SRC_URI="https://github.com//billmurrin/graylog-plugin-quickvaluesplus-widget/releases/download/${PV}/${P}.jar"
LICENSE="Apache License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/graylog"

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
   cp ${DISTDIR}/${P}.jar ${WORKDIR}/${PN}.jar
}

src_install() {
	insinto /opt/graylog-server/plugin/
	doins ${WORKDIR}/${PN}.jar
}

pkg_postinst() {
	ewarn "Docs located at https://github.com/billmurrin/graylog-plugin-quickvaluesplus-widget"
}
