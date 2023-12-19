#!/bin/bash
#
# Copyright 2018-2023 contributors to the Marquez project
# SPDX-License-Identifier: Apache-2.0
#
# Usage: $ ./entrypoint.sh

set -e

if [[ -z "${MARQUEZ_CONFIG}" ]]; then
  MARQUEZ_CONFIG='marquez.dev.yml'
  echo "WARNING 'MARQUEZ_CONFIG' not set, using development configuration."
fi

# Adjust java options for the http server and otel
JAVA_OPTS="${JAVA_OPTS}
  -Duser.timezone=UTC
  -Dlog4j2.formatMsgNoLookups=true
  -javaagent:opentelemetry-javaagent.jar
  -Dotel.service.name=marquez
  -Dotel.instrumentation.jdbc-datasource.enabled=true"

# Start http server with java options and configuration
java ${JAVA_OPTS} -jar marquez-*.jar server ${MARQUEZ_CONFIG}
