EAPI=5

inherit eutils

KEYWORDS="~amd64"
DESCRIPTION="Slack/Mattermost Plugin for Graylog"
HOMEPAGE="https://github.com/graylog-labs/graylog-plugin-slack"
MY_P=graylog-${PV/_/}
SRC_URI="https://github.com/graylog-labs/graylog-plugin-slack/releases/download/${PV}/${P}.jar"
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
	ewarn "Docs located at https://github.com/graylog-labs/graylog-plugin-slack"
}
