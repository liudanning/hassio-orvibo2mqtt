#!/usr/bin/with-contenv bashio
CONFIG_PATH=$(bashio::config 'config_path')

bashio::log.debug "Checking if $CONFIG_PATH exists"
if ! bashio::fs.directory_exists "$CONFIG_PATH"; then
    bashio::log.warning "config path $CONFIG_PATH not found"
    mkdir -p "$CONFIG_PATH" || bashio::exit.nok "Could not create $CONFIG_PATH"
    bashio::log.debug "Created $CONFIG_PATH"
fi

if bashio::fs.file_exists "$CONFIG_PATH/okey.json"; then
    bashio::log.info "File okey.json found, copying to /app/config"
    cp -f "$CONFIG_PATH"/okey.json /app/config/okey.json
else
    bashio::log.warning "No okey.json file found in config path, starting with default okey.json"
fi

if bashio::fs.file_exists "$CONFIG_PATH/mqtt.json"; then
    bashio::log.info "File mqtt.json found, copying to /app/config"
    cp -f "$CONFIG_PATH"/mqtt.json /app/config/mqtt.json
else
    bashio::log.warning "No mqtt.json file found in config path, starting with default mqtt.json"
fi

if bashio::fs.file_exists "$CONFIG_PATH/plugs.json"; then
    bashio::log.info "File plugs.json found, copying to /app/config"
    cp -f "$CONFIG_PATH"/plugs.json /app/config/plugs.json
else
    bashio::log.warning "No plugs.json file found in config path, starting with default plugs.json"
fi

