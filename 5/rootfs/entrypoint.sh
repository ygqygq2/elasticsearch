#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace
# shellcheck disable=SC1091

########################
# Install Elasticsearch plugins
# Globals:
#   ELASTICSEARCH_PLUGINS
# Arguments:
#   None
# Returns:
#   None
#########################
elasticsearch_install_plugins() {
    read -r -a plugins_list <<< "$(tr ',;' ' ' <<< "$ELASTICSEARCH_PLUGINS")"
    echo "Installing plugins: ${plugins_list[*]}"
    for plugin in "${plugins_list[@]}"; do
        echo "Installing plugin: $plugin"
        elasticsearch-plugin install -b -v "$plugin"
    done
}

elasticsearch_install_plugins

echo ""
exec "$@"
