#!/bin/bash

# callback for fetching the raw package data
function h3pkg_script_get_raw () {
	#
	local PUB_PATH="/home/pub/prof/steffens_ulrike/WS2014-AI"

	rsync -aP "${H3PKG_USER}@${H3PKG_REMOTE_HOME}:${PUB_PATH}" "${H3PKG_PACKAGE_HOME}/.cache"

	return $?
}

# callback for building the package
function h3pkg_script_build_package () {
	local raw_base=${H3PKG_PACKAGE_HOME}/.cache/WS2014-AI
	#
	cd ${H3PKG_PACKAGE_HOME} && {
		rm -rf ai
		mkdir -p ai
		cd ai && {
			mkdir -p doc lab etc

			cp -aR ${raw_base}/Praktikum/* lab
			cp -aR ${raw_base}/Vorlesung/* doc
			rm -f "doc/MPS Spezifikation.pdf"

			tar -jcf ai.tar doc lab etc
		}
	}

	return 0
}
